Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932519AbVJZBzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932519AbVJZBzE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 21:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVJZBzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 21:55:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40421 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932519AbVJZBzB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 21:55:01 -0400
Date: Tue, 25 Oct 2005 18:48:52 -0700
From: Chris Wright <chrisw@osdl.org>
To: Matt Helsley <matthltc@us.ibm.com>
Cc: Chris Wright <chrisw@osdl.org>, Greg KH <greg@kroah.com>,
       Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>,
       Evgeniy Polyakov <johnpol@2ka.mipt.ru>,
       Jean-Pierre Dion <jean-pierre.dion@bull.net>,
       Jesse Barnes <jbarnes@engr.sgi.com>,
       Guillaume Thouvenin <guillaume.thouvenin@bull.net>,
       Badari Pulavarty <pbadari@us.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
       CKRM-Tech <ckrm-tech@lists.sourceforge.net>,
       Erich Focht <efocht@hpce.nec.com>,
       elsa-devel <elsa-devel@lists.sourceforge.net>,
       Gerrit Huizenga <gh@us.ibm.com>, Adrian Bunk <bunk@stusta.de>,
       "Chandra S. Seetharaman" <sekharan@us.ibm.com>
Subject: Re: [ckrm-tech] Re: [PATCH 00/02] Process Events Connector
Message-ID: <20051026014852.GE5856@shell0.pdx.osdl.net>
References: <1130285260.10680.194.camel@stark> <20051026003430.GA27680@kroah.com> <1130288437.10680.236.camel@stark> <20051026012216.GD5856@shell0.pdx.osdl.net> <1130290233.10680.262.camel@stark>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1130290233.10680.262.camel@stark>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Matt Helsley (matthltc@us.ibm.com) wrote:
> 	It seems to me that this is the consensus here and on LSE-Tech.
> This patch addresses the needs of ELSA and CKRM and is amenable to using
> the patches recently proposed on lse-tech to pull out the common piece.

Sounds good.  What about the SGI needs (for PAGG)?  They just posted
pnotify pretty recently.   Or is that what you mean by consensus and
possible use of 'task notifiers'?

thanks,
-chris
