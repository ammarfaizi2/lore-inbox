Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265051AbTAUGHX>; Tue, 21 Jan 2003 01:07:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265095AbTAUGHX>; Tue, 21 Jan 2003 01:07:23 -0500
Received: from dhcp34.trinity.linux.conf.au ([130.95.169.34]:12416 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id <S265051AbTAUGHW>; Tue, 21 Jan 2003 01:07:22 -0500
Subject: Re: NForce Chipset support in which kernels?
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Hanasaki JiJi <hanasaki@hanaden.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3E287188.9030909@hanaden.com>
References: <3E287188.9030909@hanaden.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043052878.12182.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 20 Jan 2003 08:54:39 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-01-17 at 21:11, Hanasaki JiJi wrote:
> Was considering the purchase of a Asus A7N266-VM AA with the following 
> chipsets.   What kernel is needed to support all features? (onboard 
> video/audio/nic)?

AGP isnt supported
IDE is vaguely supported as of 2.4.21pre
Audio is partially supported (no audio accelerator)
NIC is not supported (no docs)

Its very much a 'winputer'

