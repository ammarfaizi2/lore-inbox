Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262486AbSKNTLb>; Thu, 14 Nov 2002 14:11:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262800AbSKNTLb>; Thu, 14 Nov 2002 14:11:31 -0500
Received: from fmr02.intel.com ([192.55.52.25]:52688 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262486AbSKNTL3>; Thu, 14 Nov 2002 14:11:29 -0500
Message-ID: <010501c28c12$960adef0$77d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Rusty Lynch" <rusty@linux.co.intel.com>,
       "Adam Voigt" <adam@cryptocomm.com>, <linux-kernel@vger.kernel.org>
Cc: <hch@sgi.com>
References: <1037291911.5549.4.camel@beowulf.cryptocomm.com> <003901c28c00$d1bf77b0$77d40a0a@amr.corp.intel.com>
Subject: Re: "Intermezzo" Compile Error
Date: Thu, 14 Nov 2002 11:18:16 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1106
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, I guess that was fixing some other problem.  There is a patch on
the intermezzo mailing list that claims to add the missing header files (but
I have not tried it.)

See http://sourceforge.net/mailarchive/message.php?msg_id=2291136

    -rustyl
----- Original Message -----
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Adam Voigt" <adam@cryptocomm.com>; <linux-kernel@vger.kernel.org>
Cc: <hch@sgi.com>
Sent: Thursday, November 14, 2002 9:11 AM
Subject: Re: "Intermezzo" Compile Error


> The list of changes from 2.5.46 to 2.5.47 list a fix by Christoph Hellwig
> hch@sgi.com
> for the intermezzo compile error.  Maybe the fix didn't really get
applied?
>
>     -rustyl
>
> ----- Original Message -----
> From: "Adam Voigt" <adam@cryptocomm.com>
> To: <linux-kernel@vger.kernel.org>
> Sent: Thursday, November 14, 2002 8:38 AM
> Subject: "Intermezzo" Compile Error
>
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

