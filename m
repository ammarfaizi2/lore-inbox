Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269088AbUJERSP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269088AbUJERSP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 13:18:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269091AbUJERSP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 13:18:15 -0400
Received: from rproxy.gmail.com ([64.233.170.193]:7923 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269088AbUJERSO convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 13:18:14 -0400
Message-ID: <58cb370e0410051018d37820@mail.gmail.com>
Date: Tue, 5 Oct 2004 19:18:04 +0200
From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Reply-To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
To: =?ISO-8859-1?Q?Jo=E3o_Luis_Meloni_Assirati?= 
	<assirati@nonada.if.usp.br>
Subject: Re: hpt366 under hpt372N oops
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200410050638.13426.assirati@nonada.if.usp.br>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
References: <200410050638.13426.assirati@nonada.if.usp.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

try 2.6.9-rc3

On Tue, 5 Oct 2004 06:38:13 -0300, João Luis Meloni Assirati
<assirati@nonada.if.usp.br> wrote:
> Hello,
> 
> I have an off board HighPoint RocketRAID 133 pci card. The chip is identified
> as HPT372N and there is a tag in the board printed V2.35.
> 
> I'm using the kernel 2.6.8.1 with no patches. I compiled the driver hpt366 as
> a module, and when I modprobe it, I get a segmentation fault. The kernel
> outputs the message at the end of this e-mail.
