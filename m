Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129764AbRAWLoI>; Tue, 23 Jan 2001 06:44:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130211AbRAWLn7>; Tue, 23 Jan 2001 06:43:59 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:53009 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129764AbRAWLnl>;
	Tue, 23 Jan 2001 06:43:41 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Anders Karlsson <anders.karlsson@meansolutions.com>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-ac10 compile errors 
In-Reply-To: Your message of "Tue, 23 Jan 2001 10:48:14 -0000."
             <20010123104814.A2937@alien.ssd.hursley.ibm.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 23 Jan 2001 22:43:34 +1100
Message-ID: <23801.980250214@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Jan 2001 10:48:14 +0000, 
Anders Karlsson <anders.karlsson@meansolutions.com> wrote:
>The procedure I have gone through to compile the kernel are as
>follows:
>a) Copy the .config file safe
>b) Remove the previous kernel tree
>c) Extract the pristine 2.4.0 kernel tree
>d) Apply the 2.4.0-ac10 patch

make mrproper here

>e) Copy the .config in to the new /usr/src/linux tree 
>f) make oldconfig
>g) make dep
>h) make bzImage

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
