Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261322AbTEAO4q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 10:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261336AbTEAO4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 10:56:46 -0400
Received: from smtp012.mail.yahoo.com ([216.136.173.32]:17159 "HELO
	smtp012.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261322AbTEAO4p convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 10:56:45 -0400
From: Michael Buesch <fsdeveloper@yahoo.de>
To: Scott Robert Ladd <coyote@coyotegulch.com>
Subject: Re: /dev Questions
Date: Thu, 1 May 2003 17:08:21 +0200
User-Agent: KMail/1.5.1
References: <3EB1358C.1020808@coyotegulch.com>
In-Reply-To: <3EB1358C.1020808@coyotegulch.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200305011708.52841.fsdeveloper@yahoo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 01 May 2003 16:56, Scott Robert Ladd wrote:
> Why does /dev include devices that do not exist?
>
> Wouldn't it be friendlier to only list existing devices?
>
> Or am I missing something obvious?

yea, you're missing devfs. :)

- -- 
Regards Michael Büsch
http://www.8ung.at/tuxsoft
 17:07:51 up  1:47,  2 users,  load average: 1.01, 1.09, 0.99
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+sTiEoxoigfggmSgRAlBIAJ4sdenCvafLdbY6WxEknH0ADxbfIgCcC8gx
c9mxkwFVdS93DLnT6tAJA9Q=
=b4Cq
-----END PGP SIGNATURE-----

