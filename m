Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261242AbUKZTHQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261242AbUKZTHQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:07:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261303AbUKZTHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:07:12 -0500
Received: from zeus.kernel.org ([204.152.189.113]:25022 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261242AbUKZTGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:06:18 -0500
Date: Thu, 25 Nov 2004 10:08:49 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jan Rychter <jan@rychter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Message-ID: <20041125100849.GA29539@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jan Rychter <jan@rychter.com>, linux-kernel@vger.kernel.org
References: <1101292194.5805.180.camel@desktop.cunninghams> <1101296414.5805.286.camel@desktop.cunninghams> <20041124132949.GB13145@infradead.org> <m2d5y23o61.fsf@tnuctip.rychter.com> <20041124230232.GA22509@infradead.org> <m2zn16204s.fsf@tnuctip.rychter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m2zn16204s.fsf@tnuctip.rychter.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 24, 2004 at 05:22:27PM -0800, Jan Rychter wrote:
> Please accept that there are people who requested these features and
> there are people who find them useful.

There are millions of features usefull to some people.  If these features
can be implemented without affecting the existing codebase it's usually
a no go.  If OTOH the do nasty things with kernel internals, and the feature
isn't exactly the most important in the world judgment is different.

