Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263990AbTFVO6p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 10:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264094AbTFVO6o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 10:58:44 -0400
Received: from smtp102.mail.sc5.yahoo.com ([216.136.174.140]:37387 "HELO
	smtp102.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S263990AbTFVO6n convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 10:58:43 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Ishikawa <ishikawa@yk.rim.or.jp>
Subject: Re: Warning messages during compilation of 2.4.21. (5 files)
Date: Sun, 22 Jun 2003 17:12:18 +0200
User-Agent: KMail/1.5.2
References: <3EF4B98D.33A55CD1@yk.rim.or.jp> <200306221343.26884.fsdeveloper@yahoo.de> <3EF5B80C.7F5340F7@yk.rim.or.jp>
In-Reply-To: <3EF5B80C.7F5340F7@yk.rim.or.jp>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200306221712.18912.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Sunday 22 June 2003 16:07, Ishikawa wrote:
> Unfortunately, GCC 3.3 is so clever that
> mere type casting (as you suggested) still produced warning.
> Only after assigning to an integer variable, I see
> the warning message gone. Tough luck.
> Agreed. The remedy is very ugly.

I've just tested if gcc is clever enough
to optimize the if () away. It is.
So it is not as ugly as I said in my
previous mail.

>
> Regards,
>
> Ishikawa Chiaki

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 17:10:03 up  2:04,  3 users,  load average: 1.02, 1.02, 1.00

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+9cdSoxoigfggmSgRApR+AKCImLGBDswQhYTQG96W/NG0UlBUnwCdH8TC
YFMq3a5zdxazYCLcEcmHYzA=
=xAcM
-----END PGP SIGNATURE-----

