Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135831AbRDYHrL>; Wed, 25 Apr 2001 03:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135833AbRDYHqw>; Wed, 25 Apr 2001 03:46:52 -0400
Received: from [195.6.125.97] ([195.6.125.97]:54536 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S135831AbRDYHqp>;
	Wed, 25 Apr 2001 03:46:45 -0400
Date: Wed, 25 Apr 2001 09:44:06 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: Fw: where can I find the IP address ?
Message-Id: <20010425094406.6554c0b0.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Début du message transféré :

Date: Tue, 24 Apr 2001 16:43:18 +0200
From: sébastien person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: where can I find the IP address ?


I'm dealing with a driver wich need the IP address for specifics using.

I've read in the linux device driver (o'reilly) that I can use the field
pa_addr in the struct device. but it doesn't exist on my computer.

so I don't understand why ? Is anybody could tell me where finding the
IP address in the kernel ?

thanks a lot.

nb : 	my kernel version is 2.2.14, as it is my first driver I am starting
	on the current kernel I've got but I'll also need informations
	for kernel 2.4.X

sebastien person
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/
