Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267252AbSLKSGV>; Wed, 11 Dec 2002 13:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267253AbSLKSGV>; Wed, 11 Dec 2002 13:06:21 -0500
Received: from [195.212.29.5] ([195.212.29.5]:20436 "EHLO
	d06lmsgate-5.uk.ibm.com") by vger.kernel.org with ESMTP
	id <S267252AbSLKSGT> convert rfc822-to-8bit; Wed, 11 Dec 2002 13:06:19 -0500
From: rasman@uk.ibm.com
Reply-To: rasman@uk.ibm.com
Organization: IBM
To: <chinnakka.b@bplmail.com>
Subject: Re: Kernel Module
Date: Wed, 11 Dec 2002 18:11:53 +0000
User-Agent: KMail/1.4.1
References: <2585.10.10.13.148.1039606840.squirrel@btlmail.bplmail.com>
In-Reply-To: <2585.10.10.13.148.1039606840.squirrel@btlmail.bplmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-Id: <200212111811.53135.rasman@uk.ibm.com>
X-MIMETrack: Itemize by SMTP Server on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 11/12/2002 18:14:00,
	Serialize by Router on D06ML023/06/M/IBM(Release 5.0.9a |January 7, 2002) at
 11/12/2002 18:14:04,
	Serialize complete at 11/12/2002 18:14:04
Content-Transfer-Encoding: 7BIT
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 11 Dec 2002 11:40 am, chinnakka.b@bplmail.com wrote:
> Hello sir,
> After building the kernel i tried to insert the modules
> scsi_mod,sd_mod,usb- storage
> It is giving could not find the kernel version the module was compiled for
> what is wrong with this?
> waiting for your response
> regards
> chinnakka
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Did you change the kernel version? 
If so did  you "make modules" followes by "make modules_install"?
See the kernel README


-- 
Richard J Moore
RAS Team Lead - IBM Linux Technology Centre
