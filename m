Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274990AbRJYPVu>; Thu, 25 Oct 2001 11:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275031AbRJYPVk>; Thu, 25 Oct 2001 11:21:40 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:43024 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274990AbRJYPVW>; Thu, 25 Oct 2001 11:21:22 -0400
Subject: Re: kernel compiler
To: mdiwan@wagweb.com (Frontgate Lab)
Date: Thu, 25 Oct 2001 16:28:22 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BD8222C.E741D186@wagweb.com> from "Frontgate Lab" at Oct 25, 2001 10:31:08 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15wmQg-0005Bl-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What compiler do Alan Cox and Linus use to create the 2.4 series
> kernels?

Im using Red Hat 2.96-85

> I am currently using RedHat's compiler gcc-2.96-85 and have been told
> not to do so because it "breaks things" .

Generally ignore that story: 2.96-54 has problems, but not the later ones

> The question would be .. how hard is it going to be for me to upgrade to
> gcc 3 +  and  will i get any benefit from it?  WillI loose any
> advantages that i currently do have?

Gcc 3.0 doesn't always build correct kernels. Its very much a .0 release -
new infrastructure, the core to do far better thinga than gcc 2.* but not
yet the actual results as the bugs all get kicked out

> Or can i still get what i need from compiling 2.4.12 or 2.4.13 with the
> compiler I have now?

Yeah
