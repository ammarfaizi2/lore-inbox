Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266580AbRGYVvy>; Wed, 25 Jul 2001 17:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266967AbRGYVvo>; Wed, 25 Jul 2001 17:51:44 -0400
Received: from jalon.able.es ([212.97.163.2]:50940 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S266580AbRGYVvd>;
	Wed, 25 Jul 2001 17:51:33 -0400
Date: Wed, 25 Jul 2001 23:55:58 +0200
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i2c update to 2.6.0 for 2.4.7
Message-ID: <20010725235558.A1211@werewolf.able.es>
In-Reply-To: <20010725024629.E2308@werewolf.able.es> <E15POks-00020Y-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E15POks-00020Y-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Wed, Jul 25, 2001 at 15:31:14 +0200
X-Mailer: Balsa 1.1.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


On 20010725 Alan Cox wrote:
>> It was done on 2.4.6-ac5, but should apply on 2.4.7. Only problem is those
>> document references in <file:.......> format, that are not suitable for plain 2.4.7.
>
>I sent Linus the <file: > fixes so they should be in 2.4.7
>

In Documentation/Condigure.help in my tree (incrmentally patched without errors
since 2.4.0), the only references
to Documentation/* in <file: > shape are in CONFIG_USB_CATC and CONFIG_NTFS_FS.
The rest are plain Doc/* refs.
 
-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.1 (Cooker) for i586
Linux werewolf 2.4.7 #1 SMP Mon Jul 23 01:55:36 CEST 2001 i686
