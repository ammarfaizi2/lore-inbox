Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751840AbWDDIaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751840AbWDDIaU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Apr 2006 04:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751842AbWDDIaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Apr 2006 04:30:19 -0400
Received: from pproxy.gmail.com ([64.233.166.182]:41999 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751840AbWDDIaS convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Apr 2006 04:30:18 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=qw4rcM+KVXNTl81/IQX7CMhHJk9EoXkjRKYL+qGAEEBW6+1veZpi8CKghJBCzQB5LEDGdzS+0ceaPRC0nAMg3GwwIkUZo50k3LxFeT8ZWEcJXkkBL7tfuyZHNjkbU4Fsq7hqB7QO4qE5uZbAU/DyKsgHa5znnGol6IJBH5Lnkc4=
Message-ID: <8bf247760604040130n155eeffauc5798750f8357bca@mail.gmail.com>
Date: Tue, 4 Apr 2006 01:30:17 -0700
From: Ram <vshrirama@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: SDIO Drivers?
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
   i want to write an SDIO driver. There is not much information of
what an SDIO driver is
   supposed to do or any sample sdio drivers.

   I have a few questions regarding that:

   1) What is an SDIO Driver?.

   2) Is SDIO a protocol/standard to which all devices confirm?.

   3)  Is it a generic driver ?. (Same for a set of devices) or
different for each device?
        Suppose i want to run an SDIO WLAN Card?. will the
manufacturer support it or
       an will a Generic Driver "drive" it?

   4) What is a SD Driver?

   5) What are the differences between SD Driver and SDIO Driver?.


   6) Are there any sample/Open Source SDIO drivers available in Linux
Kernel or else where?.If, not when can one expect/is anyone working on
it currently?.


  Please CC your responses to  vshrirama-at-gmail.com

Thanks and Regards,
sriram
