Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289049AbSAZKNu>; Sat, 26 Jan 2002 05:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289050AbSAZKNk>; Sat, 26 Jan 2002 05:13:40 -0500
Received: from smtp3.libero.it ([193.70.192.53]:16809 "EHLO smtp3.libero.it")
	by vger.kernel.org with ESMTP id <S289049AbSAZKNe>;
	Sat, 26 Jan 2002 05:13:34 -0500
From: Andrea Ferraris <andrea_ferraris@libero.it>
Reply-To: andrea_ferraris@libero.it
Date: Sat, 26 Jan 2002 11:11:50 +0100
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain;
  charset="us-ascii"
Cc: linux-kernel@vger.kernel.org
To: Jeff Garzik <jgarzik@mandrakesoft.com>
In-Reply-To: <20020125180149.GB45738@compsoc.man.ac.uk> <0201252332430B.01074@af> <3C51E36B.6296299D@mandrakesoft.com>
In-Reply-To: <3C51E36B.6296299D@mandrakesoft.com>
Subject: Re: eth0: NULL pointer encountered in RX ring, skipping
MIME-Version: 1.0
Message-Id: <0201261111500C.01074@af>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friday 25 January 2002 23:59, Jeff Garzik scrisse:
> Well, the code says "this should never happen" ;-)
>
> But anyway, it is probably a temporary memory allocation failure.  The
> code handles this case.

Yes, but I think that isn't normal to have to do a cold reboot to have the 
machine again working on the network. It is, maybe that the code doesn't 
handle so well this case. Do you suggest a kernel upgrade?

Andrea
