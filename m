Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281337AbRKVSyu>; Thu, 22 Nov 2001 13:54:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281326AbRKVSxQ>; Thu, 22 Nov 2001 13:53:16 -0500
Received: from mail-smtp.uvsc.edu ([161.28.224.157]:44488 "HELO
	MAIL-SMTP.uvsc.edu") by vger.kernel.org with SMTP
	id <S281337AbRKVSxE> convert rfc822-to-8bit; Thu, 22 Nov 2001 13:53:04 -0500
Message-Id: <sbfce764.052@MAIL-SMTP.uvsc.edu>
X-Mailer: Novell GroupWise Internet Agent 5.5.4.1
Date: Thu, 22 Nov 2001 11:53:51 -0700
From: "Tyler BIRD" <birdty@uvsc.edu>
To: <P.Titera@century.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Filesize limit on SMBFS
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ext2 Filesystems I believe have the limit of 2 GB.  Ext3 Extends that Limit to something??
Try making the ext3 filesystem partitions and sharing those.  
I don't know limits on FAT32 or any other filesystem you can share

Tyler

>>> Petr Tite(ra <P.Titera@century.cz> 11/22/01 02:10AM >>>
Hello,

    is maximum file size on SMBFS really 2GB? I cannot create file 
bigger than that.

Petr Titera
P.Titera@century.cz 


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org 
More majordomo info at  http://vger.kernel.org/majordomo-info.html 
Please read the FAQ at  http://www.tux.org/lkml/

