Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTKUKev (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Nov 2003 05:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264354AbTKUKev
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Nov 2003 05:34:51 -0500
Received: from gaia.cela.pl ([213.134.162.11]:13833 "EHLO gaia.cela.pl")
	by vger.kernel.org with ESMTP id S264353AbTKUKeu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Nov 2003 05:34:50 -0500
Date: Fri, 21 Nov 2003 11:33:30 +0100 (CET)
From: Maciej Zenczykowski <maze@cela.pl>
To: Andrew Miklas <public@mikl.as>
cc: benh@kernel.crashing.org, <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Announce: ndiswrapper
In-Reply-To: <200311202150.23184.public@mikl.as>
Message-ID: <Pine.LNX.4.44.0311211132040.10515-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Actually, one ongoing project is to get the Broadcom driver with ndiswrapper 
> to run inside an emulator like bochs, so we can monitor all the IO.  
> Actually, something I posted last week about doing DMA to userspace was for 
> this project.

If you can get this to run in userspace I can provide an IO-trace enabled 
strace for x86 (which is still in the works but will likely be enough for 
you).

Cheers,
MaZe.


