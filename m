Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281488AbRKVTVe>; Thu, 22 Nov 2001 14:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281495AbRKVTVZ>; Thu, 22 Nov 2001 14:21:25 -0500
Received: from mail.terraempresas.com.br ([200.177.96.20]:9739 "EHLO
	mail.terraempresas.com.br") by vger.kernel.org with ESMTP
	id <S281488AbRKVTVM>; Thu, 22 Nov 2001 14:21:12 -0500
Message-ID: <001501c1738b$2a4be5b0$1300a8c0@marcelo>
From: "Marcelo Borges Ribeiro" <marcelo@datacom-telematica.com.br>
To: "Tyler BIRD" <birdty@uvsc.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <sbfce764.052@MAIL-SMTP.uvsc.edu>
Subject: Re: Filesize limit on SMBFS
Date: Thu, 22 Nov 2001 17:23:13 -0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This limit is a kernel´s limit not a file system´s limit. Even vfat has a
limitation of 2GB under linux. I thought with kernel 2.4.x this will be
over.
----- Original Message -----
From: "Tyler BIRD" <birdty@uvsc.edu>
To: <P.Titera@century.cz>; <linux-kernel@vger.kernel.org>
Sent: Thursday, November 22, 2001 4:53 PM
Subject: Re: Filesize limit on SMBFS


> Ext2 Filesystems I believe have the limit of 2 GB.  Ext3 Extends that
Limit to something??
> Try making the ext3 filesystem partitions and sharing those.
> I don't know limits on FAT32 or any other filesystem you can share
>
> Tyler
>
> >>> Petr Tite(ra <P.Titera@century.cz> 11/22/01 02:10AM >>>
> Hello,
>
>     is maximum file size on SMBFS really 2GB? I cannot create file
> bigger than that.
>
> Petr Titera
> P.Titera@century.cz
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

