Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262462AbUCJHhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 02:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262396AbUCJHhW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 02:37:22 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:54792 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S262462AbUCJHhS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 02:37:18 -0500
Content-Type: text/plain; charset=US-ASCII
From: vda <vda@port.imtp.ilyichevsk.odessa.ua>
To: Stefan Smietanowski <stesmi@stesmi.com>,
       "Smart, James" <James.Smart@Emulex.com>
Subject: Re: [Announce] Emulex LightPulse Device Driver
Date: Wed, 10 Mar 2004 09:21:46 +0200
X-Mailer: KMail [version 1.4]
Cc: "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
References: <3356669BBE90C448AD4645C843E2BF2802C014D7@xbl.ma.emulex.com> <404E5CC3.9010305@stesmi.com>
In-Reply-To: <404E5CC3.9010305@stesmi.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200403100921.46432.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 10 March 2004 02:09, Stefan Smietanowski wrote:
> Smart, James wrote:
> > All,
> >
> > Emulex is embarking on an effort to open source the driver for its
> > LightPulse Fibre Channel Adapter family. This effort will migrate
> > Emulex's current code base to a driver centric to the Linux 2.6 kernel,
> > with the goal to eventually gain inclusion in the base Linux kernel.
> >
> > A new project has been created on SourceForge to host this effort - see
> > http://sourceforge.net/projects/lpfcxxxx/ . Further information, such as
> > the lastest FAQ, can be found on the project site.
> >
> > We realize that this will be a significant effort for Emulex. We welcome
> > any feedback that the community can provide us.
>
> I wish to just tell you that I think you're doing the Right Thing(TM).
>
> There are people that don't buy hardware for which the source isn't
> either available or included in the standard kernel, even if there
> are more patches or newer driver versions external to the main tree.

Being bitten by "buggy firmware from hell", I, too, will abstain from
using hardware from manufactures who do not open driver source
for impossible-to-understand reasons.
--
vda
