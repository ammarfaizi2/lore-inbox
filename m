Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269085AbTCAXoP>; Sat, 1 Mar 2003 18:44:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269086AbTCAXoP>; Sat, 1 Mar 2003 18:44:15 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:13318 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S269085AbTCAXoO>; Sat, 1 Mar 2003 18:44:14 -0500
Date: Sun, 2 Mar 2003 10:54:08 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Brad Laue <brad@brad-x.com>
cc: Marc Giger <gigerstyle@gmx.ch>, <jt@hpl.hp.com>,
       <linux-kernel@vger.kernel.org>, <breed@users.sourceforge.net>,
       <achirica@users.sourceforge.net>
Subject: Re: Cisco Aironet 340 oops with 2.4.20
In-Reply-To: <3E6141F9.5060709@brad-x.com>
Message-ID: <Pine.LNX.4.44.0303021053170.4620-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Mar 2003, Brad Laue wrote:

> Still crashes:
> 
> static const char version[] = "$Revision: 1.46 $";
> 
> ksymoops output attached.
> 

Can you reproduce the crash without the Nvidia module loaded?


- James
-- 
James Morris
<jmorris@intercode.com.au>


