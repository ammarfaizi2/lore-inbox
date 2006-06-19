Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964935AbWFSWGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964935AbWFSWGK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 18:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964940AbWFSWGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 18:06:09 -0400
Received: from mailfe06.tele2.fr ([212.247.154.172]:28827 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S964935AbWFSWGI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 18:06:08 -0400
X-T2-Posting-ID: dCnToGxhL58ot4EWY8b+QGwMembwLoz1X2yB7MdtIiA=
X-Cloudmark-Score: 0.000000 []
Date: Tue, 20 Jun 2006 00:06:06 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: emergency or init=/bin/sh mode and terminal signals
Message-ID: <20060619220606.GA5788@implementation.residence.ens-lyon.fr>
Mail-Followup-To: Samuel Thibault <samuel.thibault@ens-lyon.org>,
	"linux-os (Dick Johnson)" <linux-os@analogic.com>,
	linux-kernel@vger.kernel.org
References: <20060618212303.GD4744@bouh.residence.ens-lyon.fr> <Pine.LNX.4.61.0606190730070.27378@chaos.analogic.com> <20060619114617.GM4253@implementation.labri.fr> <Pine.LNX.4.61.0606190802110.27505@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0606190802110.27505@chaos.analogic.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

linux-os (Dick Johnson), le Mon 19 Jun 2006 08:05:01 -0400, a écrit :
> On Mon, 19 Jun 2006, Samuel Thibault wrote:
> > linux-os (Dick Johnson), le Mon 19 Jun 2006 07:37:02 -0400, a écrit :
> >> I don't think this is the correct behavior. You can't allow some
> >> terminal input to affect init. It has been the de facto standard
> >> in Unix, that the only time one should have a controlling terminal
> >> is after somebody logs in and owns something to control. If you want
> >> a controlling terminal from your emergency shell, please exec /bin/login.
> >
> > Ok, but people don't know that: they're given a shell, and wonder why on
> > hell ^C doesn't work...
> 
> Maybe, but you shouldn't modify the kernel for "training". The kernel
> needs to be sacrosanct.

?? I can't find out what I should understand.

Samuel
