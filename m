Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313142AbSDDLqL>; Thu, 4 Apr 2002 06:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313137AbSDDLpv>; Thu, 4 Apr 2002 06:45:51 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:36619 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S313142AbSDDLpm>; Thu, 4 Apr 2002 06:45:42 -0500
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
To: kaih@khms.westfalen.de (Kai Henningsen)
Date: Thu, 4 Apr 2002 13:01:36 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <8MC61VRHw-B@khms.westfalen.de> from "Kai Henningsen" at Apr 04, 2002 08:26:00 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16t5vs-0005mZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Frankly, I believe that it is both illegal (by the GPL) and morally  
> bankrupt to add these "GPL only" symbols to the kernel *unless* you can  
> get agreement for them fro *all* kernel copyright holders.

Other way around. Remember the kernel is GPL not LGPL
