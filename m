Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267433AbTALToN>; Sun, 12 Jan 2003 14:44:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267435AbTALToM>; Sun, 12 Jan 2003 14:44:12 -0500
Received: from 60.54.252.64.snet.net ([64.252.54.60]:31076 "EHLO
	mail.blue-labs.org") by vger.kernel.org with ESMTP
	id <S267433AbTALToL>; Sun, 12 Jan 2003 14:44:11 -0500
Message-ID: <3E21C794.6070606@blue-labs.org>
Date: Sun, 12 Jan 2003 14:52:52 -0500
From: David Ford <david+cert@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030110
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.56 panics PostgreSQL
References: <3E21B839.4060902@blue-labs.org> <200301121137.07735.akpm@digeo.com>
In-Reply-To: <200301121137.07735.akpm@digeo.com>
X-Enigmail-Version: 0.71.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Reiserfs.  Postgres is the only program that had problems, but it's also
the one that does 99% of all the activity on the system.

David

Andrew Morton wrote:

>On Sun January 12 2003 10:47, David Ford wrote:
>  
>
>>Yesterday I put 2.5.56 on my SQL server and PostgreSQL started panicking 
>>repeatedly and frequently complaining about missing commit logs.
>>    
>>
>
>Which filesystems were in use?
>
>
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQE+IceU74cGT/9uvgsRAjVyAKChsd6nugAaDKYipYoiEOnaZD0qMgCgkZTb
bx8trXNJtflndfjwrcroJSI=
=+Rqc
-----END PGP SIGNATURE-----

