Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278080AbRJKDVF>; Wed, 10 Oct 2001 23:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278079AbRJKDUz>; Wed, 10 Oct 2001 23:20:55 -0400
Received: from smtp2.orcon.net.nz ([210.55.12.15]:63494 "EHLO
	smtp2.orcon.net.nz") by vger.kernel.org with ESMTP
	id <S278080AbRJKDUj>; Wed, 10 Oct 2001 23:20:39 -0400
Message-ID: <03c201c15204$9519b000$6d0e37d2@lennon>
From: "Craig Whitmore" <lennon@orcon.net.nz>
To: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>,
        <linux-kernel@vger.kernel.org>
In-Reply-To: <01101018290109.11498@localhost.localdomain> <35731.24.255.76.12.1002768539.squirrel@webmail.morcant.org>
Subject: Re: 2.4.11 UDF
Date: Thu, 11 Oct 2001 16:26:46 +1300
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

MAtrix is Encrypted and 5th Element is not Encrypted.. That seems to be the
only difference between them..

Thanks
Craig Whitmore

----- Original Message -----
From: "Morgan Collins [Ax0n]" <sirmorcant@morcant.org>
To: <linux-kernel@vger.kernel.org>
Sent: Thursday, October 11, 2001 3:48 PM
Subject: 2.4.11 UDF


> Hi,
>
> I recieve the following when mounting The Matrix:
>
> Oct 10 19:40:40 ember kernel: UDF-fs INFO UDF 0.9.4.1-ro (2001/06/13)
Mounting volume
> 'THE_MATRIX_16X9LB_N_AMERICA', timestamp 1999/08/02 17:29 (1e5c)
>
> However, upon ls, I get an empty directory and the following errors dumped
to syslog:
>
> Oct 10 19:40:41 ember kernel: UDF-fs DEBUG
directory.c:237:udf_get_fileident: 0x0 !=
> TID_FILE_IDENT_DESC
> Oct 10 19:40:41 ember kernel: UDF-fs DEBUG
directory.c:239:udf_get_fileident: offset: 532
> sizeof: 38 bufsize: 2048
>
> I can however mount the 5th Element and I see the following, and recieve
no errors and a
> correct ls.
> Oct 10 19:44:11 ember kernel: UDF-fs INFO UDF 0.9.4.1-ro (2001/06/13)
Mounting volume
> 'DVD_VIDEO', timestamp 1997/10/28 11:44 (1e5c)
>
> I didn't use UDF in 2.4.10, so perhaps this has already been discussed, if
so clue me in :>
>
> --
> Morgan Collins [Ax0n] http://sirmorcant.morcant.org
> Software is something like a machine, and something like mathematics, and
something like
> language, and something like thought, and art, and information.... but
software is not in
> fact any of those other things.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

