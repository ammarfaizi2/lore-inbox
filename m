Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136024AbREBX6X>; Wed, 2 May 2001 19:58:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136092AbREBX6N>; Wed, 2 May 2001 19:58:13 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:34067 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S136016AbREBX6K>; Wed, 2 May 2001 19:58:10 -0400
Subject: Re: Complete support for Intel 815 chipset?
To: phil@theoesters.com (Phil Oester)
Date: Thu, 3 May 2001 01:02:10 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <LAEOJKHJGOLOPJFMBEFEMEOPDHAA.phil@theoesters.com> from "Phil Oester" at May 02, 2001 04:06:00 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14v6ZR-0004bZ-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This may not matter in terms of performance, but many devices on Intel 815
> chipset machines show up as unknown.  Any ideas when (or if) full support
> for the 815 is planned?

Get a newer lspci if there is one yet. It is simply down to the number/name
table in lspci not the kernel what is printed

