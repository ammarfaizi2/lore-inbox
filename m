Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135657AbRDXOqT>; Tue, 24 Apr 2001 10:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135656AbRDXOqJ>; Tue, 24 Apr 2001 10:46:09 -0400
Received: from [195.6.125.97] ([195.6.125.97]:45578 "EHLO looping.sycomore.fr")
	by vger.kernel.org with ESMTP id <S135657AbRDXOqC>;
	Tue, 24 Apr 2001 10:46:02 -0400
Date: Tue, 24 Apr 2001 16:43:18 +0200
From: =?ISO-8859-1?Q?s=E9bastien?= person <sebastien.person@sycomore.fr>
To: liste noyau linux <linux-kernel@vger.kernel.org>
Subject: where can I find the IP address ?
Message-Id: <20010424164318.34eadd2d.sebastien.person@sycomore.fr>
X-Mailer: Sylpheed version 0.4.64 (GTK+ 1.2.6; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
