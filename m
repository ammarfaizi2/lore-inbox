Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271505AbTGQPlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 11:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271506AbTGQPlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 11:41:11 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:11526 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271505AbTGQPlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 11:41:10 -0400
Date: Thu, 17 Jul 2003 16:56:03 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Ro0tSiEgE LKML <lkml@ro0tsiege.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: devfsd
Message-ID: <20030717165603.A8369@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Ro0tSiEgE LKML <lkml@ro0tsiege.org>, linux-kernel@vger.kernel.org
References: <20030715214610.GA21238@core.citynetwireless.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030715214610.GA21238@core.citynetwireless.net>; from lkml@ro0tsiege.org on Tue, Jul 15, 2003 at 04:46:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 15, 2003 at 04:46:10PM -0500, Ro0tSiEgE LKML wrote:
> Why is devfsd still tagged as EXPERIMENTAL even in 2.6.0-test1 ? Is
> there something wrong with it, or has it just not been changed?

It's still there because we don't have a BROKEN tag.

