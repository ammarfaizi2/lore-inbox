Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266932AbSKURNb>; Thu, 21 Nov 2002 12:13:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266931AbSKURNb>; Thu, 21 Nov 2002 12:13:31 -0500
Received: from fmr01.intel.com ([192.55.52.18]:20188 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266932AbSKURN3>;
	Thu, 21 Nov 2002 12:13:29 -0500
Message-ID: <001801c29182$4d1fa250$94d40a0a@amr.corp.intel.com>
From: "Rusty Lynch" <rusty@linux.co.intel.com>
To: "Patrick Mochel" <mochel@osdl.org>,
       "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.33.0211211103270.913-100000@localhost.localdomain>
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use
Date: Thu, 21 Nov 2002 09:20:34 -0800
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

I used the one submitted by Vamsi in
http://marc.theaimsgroup.com/?l=linux-kernel&m=103761676628192&w=2

I think IBM has a kprobes webpage with a link to the patch, but I also have
copy of the one I used at:
http://www.stinkycat.com/patches/patch-kprobes-2.5.48.diff

    -rustyl

----- Original Message -----
From: "Patrick Mochel" <mochel@osdl.org>
To: "Rusty Lynch" <rusty@linux.co.intel.com>
Cc: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Sent: Thursday, November 21, 2002 9:04 AM
Subject: Re: [BUG] sysfs on 2.5.48 unable to remove files while in use


>
> Hi there.
>
> > My patch to 2.5.48 (with kprobes already applied) can be
> > grabbed from:
> >
http://www.stinkycat.com/patches/patch-kprobes_sample_with_sysfs-2.5.48.diff
>
> Where is the kprobes patch?
>
> Thanks,
>
> -pat
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

