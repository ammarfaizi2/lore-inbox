Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316135AbSEWGjN>; Thu, 23 May 2002 02:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316156AbSEWGjM>; Thu, 23 May 2002 02:39:12 -0400
Received: from goliath.siemens.de ([192.35.17.28]:45823 "EHLO
	goliath.siemens.de") by vger.kernel.org with ESMTP
	id <S316135AbSEWGjM>; Thu, 23 May 2002 02:39:12 -0400
From: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
To: linux-kernel@vger.kernel.org
Date: Thu, 23 May 2002 10:39:05 +0400 (MSD)
X-X-Sender: bor@itsrm2.mow.siemens.ru
Subject: Re: ehci-hcd on CARDBUS hangs when stopping card service
In-Reply-To: <Pine.SV4.4.44.0205231018300.7427-100000@itsrm2.mow.siemens.ru>
Message-ID: <Pine.SV4.4.44.0205231034270.7427-100000@itsrm2.mow.siemens.ru>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 May 2002, Andrej Borsenkow wrote:

> There were several reports about Linux hanging on shutdown. In one case
> hardware was Dell Inspirion 8100 with Cardbus slot (Texas Instruments
> PCI4451) and Adaptec USB2connect (aua-1420) controller.
>

Sorry, was too fast to hit send. Kernel is 2.4.18-6mdk (based on
2.4.18)

-andrej
