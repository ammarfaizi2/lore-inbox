Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSEDTrD>; Sat, 4 May 2002 15:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315205AbSEDTrC>; Sat, 4 May 2002 15:47:02 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:22536 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S315198AbSEDTrC>; Sat, 4 May 2002 15:47:02 -0400
Message-Id: <200205041944.g44JiEX12535@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: Virtual address space exhaustion (was Discontigmem virt_to_page() )
Date: Sat, 4 May 2002 22:49:23 -0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1020503152328.8539A-100000@chaos.analogic.com> <222870000.1020465352@flay>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3 May 2002 20:35, Martin J. Bligh wrote:
> > No. It's not stupid. Unix defines a kind of operating system that
> > has certain characteristics and/or attributes. Process/kernel shared
> > address space is one of them. It's a name that has historical
> > signifigance.
>
> Yes it is stupid. This is a small implementation detail, and has no
> real importance whatsoever. People have done this in the past
> (Dynix/PTX did it) will do so in the future. Nor does the kernel
> address space have to be global and shared across all tasks
> as stated earlier in this thread. What makes it Unix is the interface
> it presents to the world, and how it behaves, not the little details
> of how it's implemented inside.

I'm curious where it is visible to userspace?
(I'm asking for educational purposes)
--
vda
