Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263041AbUE1Io2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263041AbUE1Io2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 May 2004 04:44:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265964AbUE1Io2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 May 2004 04:44:28 -0400
Received: from mail.eris.qinetiq.com ([128.98.1.1]:52128 "HELO
	mail.eris.qinetiq.com") by vger.kernel.org with SMTP
	id S263041AbUE1Io0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 May 2004 04:44:26 -0400
From: Mark Watts <m.watts@eris.qinetiq.com>
Organization: QinetiQ
To: Linux Kernel Mail List <linux-kernel@vger.kernel.org>
Subject: Re: ftp.kernel.org
Date: Fri, 28 May 2004 09:41:38 +0100
User-Agent: KMail/1.5.3
References: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net>
In-Reply-To: <Pine.GSO.4.33.0405280018250.14297-100000@sweetums.bluetronic.net>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200405280941.38784.m.watts@eris.qinetiq.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


> On Thu, 27 May 2004, Martin J. Bligh wrote:
> >They switched to vsftpd very recently ... presumably then.
>
> That would explain it.  The default is to turn it off.
>
> >Why would you mirror via ftp, instead of rsync anyway?
>
> I have more control with mirror.  And I've been using mirror for
> *ahem* a decade.  I've been using rsync for mirroring debian, but
> it's slow and often fails to complete.  Mirror has never let me
> down ('tho it has deleted entire archives before *grin*)

Agreed - fmirror is so much more reliable than rsync (imho) that it makes 
rsync into a worst-case option for retrieving files.

- -- 
Mark Watts
Senior Systems Engineer
QinetiQ Trusted Information Management
Trusted Solutions and Services group
GPG Public Key ID: 455420ED

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQFAtvtCBn4EFUVUIO0RAl6dAJ9C+1Xu6nIMTFI3ggchYyEAXTu7fACgm9Vt
1VZ6sy9Ra/iK6MvCkxRUxVk=
=3PkP
-----END PGP SIGNATURE-----

