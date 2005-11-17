Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964840AbVKQT5X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964840AbVKQT5X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 14:57:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbVKQT5X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 14:57:23 -0500
Received: from mustang.oldcity.dca.net ([216.158.38.3]:13462 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S964840AbVKQT5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 14:57:22 -0500
Subject: Re: [linux-pm] [RFC] userland swsusp
From: Lee Revell <rlrevell@joe-job.com>
To: Olivier Galibert <galibert@pobox.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux-pm mailing list <linux-pm@lists.osdl.org>
In-Reply-To: <20051117170202.GB10402@dspnet.fr.eu.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	 <20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	 <20051116220500.GF12505@elf.ucw.cz>
	 <20051117170202.GB10402@dspnet.fr.eu.org>
Content-Type: text/plain
Date: Thu, 17 Nov 2005 14:57:11 -0500
Message-Id: <1132257432.4438.8.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-17 at 18:02 +0100, Olivier Galibert wrote:
> On Wed, Nov 16, 2005 at 11:05:00PM +0100, Pavel Machek wrote:
> > Now... if something can be
> > done in userspace, it probably should.
> 
> And that usually means it just isn't done.  Cases in point:
> multichannel audio software mixing, video pixel formats conversion.

What are you talking about?  ALSA does mixing in userspace, it works
great.

Lee

