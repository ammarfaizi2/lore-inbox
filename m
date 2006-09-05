Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965164AbWIERkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965164AbWIERkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 13:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965204AbWIERkm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 13:40:42 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:62657 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S965164AbWIERkl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 13:40:41 -0400
Subject: Re: [Feature] x86_64 page tracking for Stratus servers
From: Arjan van de Ven <arjan@infradead.org>
To: Kimball Murray <kimball.murray@gmail.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com, ak@suse.de
In-Reply-To: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
References: <20060905173229.14149.60535.sendpatchset@dhcp83-86.boston.redhat.com>
Content-Type: text/plain
Organization: Intel International BV
Date: Tue, 05 Sep 2006 19:40:21 +0200
Message-Id: <1157478021.9036.29.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 13:34 -0400, Kimball Murray wrote:
> Attached is a git patch that implements a feature that is used by Stratus
> fault-tolerant servers running on Intel x86_64 platforms.  It provides the
> kernel mechanism that allows a loadable module to be able to keep track of
> recently dirtied pages for the purpose of copying live, currently active
> memory, to a spare memory module.


last time this came up, your module wasn't open source.... has that
changed since?
Maybe you should just post it...



