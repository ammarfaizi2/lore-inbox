Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267178AbSLKPBh>; Wed, 11 Dec 2002 10:01:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267180AbSLKPBh>; Wed, 11 Dec 2002 10:01:37 -0500
Received: from pc2-cwma1-4-cust129.swan.cable.ntl.com ([213.105.254.129]:40898
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267178AbSLKPBg>; Wed, 11 Dec 2002 10:01:36 -0500
Subject: Re: Oops 2.4.20-ac1 & 2.4.21-pre1 ide-scsi
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Alexander Grishin <gri@ses.bryansk.elektra.ru>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200212110907.58987.gri@ses.bryansk.elektra.ru>
References: <200212110907.58987.gri@ses.bryansk.elektra.ru>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 11 Dec 2002 15:46:36 +0000
Message-Id: <1039621596.17702.17.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-12-11 at 06:07, Alexander Grishin wrote:
> The next commands:
> 
>   modprobe ide-scsi
>   rmmod ide-scsi
>   mount -t iso9660 /dev/hdc /mnt

I'll look into that

