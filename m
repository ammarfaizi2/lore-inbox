Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262872AbTCSAQf>; Tue, 18 Mar 2003 19:16:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262875AbTCSAQe>; Tue, 18 Mar 2003 19:16:34 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:12250 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S262872AbTCSAQd>;
	Tue, 18 Mar 2003 19:16:33 -0500
Date: Wed, 19 Mar 2003 01:27:28 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: micklweiss@gmx.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux on 16-bit processors
Message-ID: <20030319002728.GC4278@werewolf.able.es>
References: <17232.1048031207@www59.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <17232.1048031207@www59.gmx.net>; from micklweiss@gmx.net on Wed, Mar 19, 2003 at 00:46:47 +0100
X-Mailer: Balsa 2.0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 03.19, micklweiss@gmx.net wrote:
> I'm interested on running Linux on some less powerful, cheaper 16 bit
> systems. I would like to know if there is a slimmed down version of the kernel (any
> version 2.2+) that can run on 16-bit CPUs. I know that linux "requires" a
> 32-bit CPU, but I know that it has run on less. I'm interested in any arch -
> really. 

http://www.uclinux.org/

It doesn't need an mmu, boots on a Palm. ;) Look  in 'uClinux Ports'

Or http://www.linux.org/projects/ports.html, look for m68k ports, don't know
if any of them work on cpus below 68020.


-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.21-pre5-jam0 (gcc 3.2.2 (Mandrake Linux 9.1 3.2.2-3mdk))
