Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261619AbTHTAJT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 20:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTHTAJT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 20:09:19 -0400
Received: from smtp02.mrf.mail.rcn.net ([207.172.4.61]:21693 "EHLO
	smtp02.mrf.mail.rcn.net") by vger.kernel.org with ESMTP
	id S261619AbTHTAJN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 20:09:13 -0400
From: "Bryan D. Stine" <admin@kentonet.net> (by way of Bryan D. Stine
	<admin@kentonet.net>)
Organization: KentoNET Communications
Subject: Re: DVD ROM on 2.6
Date: Tue, 19 Aug 2003 20:09:07 -0400
User-Agent: KMail/1.5.3
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200308192009.11298.admin@kentonet.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Try passing the -t iso9660 option to mount or (if that doesn't work) you
 could go so far as to removing the UDF support from the kernel.

On Tuesday 19 August 2003 07:34 pm, Wakko Warner wrote:
> I'm trying out 2.6 on one of my test boxes with an IDE dvd drive.  I'm
> using ide-scsi (I prefer scdx as opposed to hdx).  I noticed that any
> attempt to mount a DVD movie (lord of the rings comes to mind) it mounts as
> UDF.  My laptop mounts this same dvd as iso9660.
>
> I've also been unable to play DVDs on this machine, but I don't have the
> same packages installed as I do on my laptop.

- - --
Bryan D. Stine
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/Qrwl4Cdq/Vbot6MRAjH5AKCHEROGxWCPeBjAW4uj4ODjRj0R7wCfScad
MJ/UsJIH2oz7wCAXVNTGbE8=
=VV4C
-----END PGP SIGNATURE-----

