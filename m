Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965229AbVIVFv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965229AbVIVFv0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 01:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965231AbVIVFv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 01:51:26 -0400
Received: from web33203.mail.mud.yahoo.com ([68.142.206.101]:23641 "HELO
	web33203.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S965229AbVIVFvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 01:51:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.ca;
  h=Message-ID:Received:Date:From:Subject:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=E+uLuoUtKc+Y5srQdTKvBJzihgeiwPU4Rthy5DVZA91W4cKGx37nWrPcrLGTdoXSUVWWg9tfw0kzcXNx1wgPgAVnx8D7KXBkpJ53Mmz9AcKonrjA9CnXZDHydMf9aAwPKfksUCFmX2OBTOfaXOcYvV2+N+2UzOEQEY3ropqhAao=  ;
Message-ID: <20050922055120.23356.qmail@web33203.mail.mud.yahoo.com>
Date: Thu, 22 Sep 2005 01:51:20 -0400 (EDT)
From: rep stsb <repstsb@yahoo.ca>
Subject: Re: In-kernel graphics subsystem
To: linux-kernel@vger.kernel.org
Cc: 06020051@lums.edu.pk
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Athar Hameed wrote: 

> We are a group of three undergrad CS students, 
> almost ready to start our senior project. We have
> this idea of integrating a graphics subsystem with
> the kernel


A thread about getting vertical synchronization
interrupts from a video card is available at, 

http://groups.google.ca/group/alt.lang.asm/browse_frm/thread/d1057c825a7933f0/f7239ffb484587d9

I have started a project to write a windowing program
on svgalib at, 

http://sourceforge.net/projects/svgalib-windows 

My idea is, 

1. Convert svgalib drivers into kernel modules to get
v-sync interrupts. 

2. Write a windowing program on svgalib. 

Everyone can join. 

> P.S. We are not subscribed to the lklm. Kindly CC
> your replies to 06020051@lums.edu.pk 

http://groups.google.ca/group/fa.linux.kernel


	

	
		
__________________________________________________________ 
Find your next car at http://autos.yahoo.ca
