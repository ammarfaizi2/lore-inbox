Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318119AbSGROtK>; Thu, 18 Jul 2002 10:49:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318122AbSGROtJ>; Thu, 18 Jul 2002 10:49:09 -0400
Received: from Morgoth.ESIWAY.NET ([193.194.16.157]:59147 "EHLO
	Morgoth.esiway.net") by vger.kernel.org with ESMTP
	id <S318119AbSGROtJ>; Thu, 18 Jul 2002 10:49:09 -0400
Date: Thu, 18 Jul 2002 16:52:00 +0200 (CEST)
From: Marco Colombo <marco@esi.it>
To: irfan_hamid@softhome.net
cc: linux-kernel@vger.kernel.org
Subject: Re: cli()/sti() clarification
In-Reply-To: <courier.3D365FDC.0000712F@softhome.net>
Message-ID: <Pine.LNX.4.44.0207181650400.1725-100000@Megathlon.ESI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Jul 2002 irfan_hamid@softhome.net wrote:

> Hi, 
> 
> I added two system calls, blockintr() and unblockintr() to give cli()/sti() 
> control to userland programs (yes I know its not advisable) but I only want 
> to do it as a test. My test program looks like this: 
> 
> 	blockintr();
> 	/* Some long calculations */
> 	unblockintr(); 

May I ask what are you trying to achieve?

.TM.

