Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbUCQQ3O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Mar 2004 11:29:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbUCQQ3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Mar 2004 11:29:14 -0500
Received: from mail.eris.qinetiq.com ([128.98.1.1]:18356 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S261671AbUCQQ3H convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Mar 2004 11:29:07 -0500
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       linux-kernel@vger.kernel.org
Subject: Re: vmware on linux 2.6.4
Date: Wed, 17 Mar 2004 16:19:43 +0000
User-Agent: KMail/1.5.3
References: <yw1xu10ogy4m.fsf@kth.se> <200403171119.48026@WOLK>
In-Reply-To: <200403171119.48026@WOLK>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200403171619.43758.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Wednesday 17 March 2004 00:39, Måns Rullgård wrote:
>
> Hi Mans,
>
> > I tried to build the vmware modules for kernel 2.6.4 and got this oops
> > when loading vmmon.o:
> > vmmon: no version magic, tainting kernel.
> > vmmon: module license 'unspecified' taints kernel.
> > Unable to handle kernel NULL pointer dereference at virtual address
> > Suggestions welcome.
>
> what vmware version do you use? Please make sure you've updated to latest
> any-any update from (1.)

What does this update actually do?

I'm currently running VMWare 4.5.1 on mandrake 10.0 Community with their 2.6.3 
kernel and VMWare is working just fine. Any compilation of modules was all 
performed by vmware-install.pl

Cheers.

Mark


- -- 
Mark Watts
Senior Systems Engineer
QinetiQ TIM
St Andrews Road, Malvern
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAWHqfBn4EFUVUIO0RAoxfAKDcilnCVu4OFBD8QAmx9BVmIJfgZACeMkGe
CBjhrmLC5D7l+Vch2SvM4As=
=X4Zb
-----END PGP SIGNATURE-----

