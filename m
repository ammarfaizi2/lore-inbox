Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276759AbRJUVJl>; Sun, 21 Oct 2001 17:09:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276761AbRJUVJa>; Sun, 21 Oct 2001 17:09:30 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:15245 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S276759AbRJUVJT>; Sun, 21 Oct 2001 17:09:19 -0400
Content-Type: text/plain; charset=US-ASCII
From: Tim Jansen <tim@tjansen.de>
To: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: The new X-Kernel !
Date: Sun, 21 Oct 2001 23:12:19 +0200
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <E15vO29-0008ED-00@calista.inka.de>
In-Reply-To: <E15vO29-0008ED-00@calista.inka.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <15vPqi-1pZTN2C@fmrl02.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 October 2001 21:13, Bernd Eckenfels wrote:
> Well, it is not a question of moving X or Office into Kernel Space. But
> current development clearly shows, that some things like Video Card Access
> need Kernel Support. IMHO the Amount of GDI related Functions in NT Kernel
> are too much, but X11 is not exactly the Windowing System you can consider
> well suited for Desktop and Game Use.

Actually some gfx code has already been moved into the kernel, see DRI and 
the nvidia kernel modules. And AFAIK there aren't any noticably speed 
differences between nvidia's linux drivers and the Windows drivers, at least 
not for 3D, so X11 can't be that bad.

bye...

