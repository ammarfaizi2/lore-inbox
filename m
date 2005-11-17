Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932424AbVKQRCM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932424AbVKQRCM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 12:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbVKQRCM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 12:02:12 -0500
Received: from dspnet.fr.eu.org ([213.186.44.138]:17426 "EHLO dspnet.fr.eu.org")
	by vger.kernel.org with ESMTP id S932435AbVKQRCK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 12:02:10 -0500
Date: Thu, 17 Nov 2005 18:02:02 +0100
From: Olivier Galibert <galibert@pobox.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
Subject: Re: [linux-pm] [RFC] userland swsusp
Message-ID: <20051117170202.GB10402@dspnet.fr.eu.org>
Mail-Followup-To: Olivier Galibert <galibert@pobox.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux-pm mailing list <linux-pm@lists.osdl.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com> <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost> <20051116220500.GF12505@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051116220500.GF12505@elf.ucw.cz>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2005 at 11:05:00PM +0100, Pavel Machek wrote:
> Now... if something can be
> done in userspace, it probably should.

And that usually means it just isn't done.  Cases in point:
multichannel audio software mixing, video pixel formats conversion.

  OG.
