Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286254AbRLJM75>; Mon, 10 Dec 2001 07:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286255AbRLJM7r>; Mon, 10 Dec 2001 07:59:47 -0500
Received: from trappist.elis.rug.ac.be ([157.193.67.1]:3304 "EHLO
	trappist.elis.rug.ac.be") by vger.kernel.org with ESMTP
	id <S286254AbRLJM7m>; Mon, 10 Dec 2001 07:59:42 -0500
Date: Mon, 10 Dec 2001 13:59:33 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: Sarita N <sarita_navuluru@rediffmail.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: KERNEL SYSTEM CALLS DEFINITIONS
In-Reply-To: <20011209225143.30988.qmail@mailweb22.rediffmail.com>
Message-ID: <Pine.LNX.4.33.0112101358190.12402-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I have to build a tool in C that would caputure the system calls and 
> signals between a user application and the operating system.  

See 'man ptrace' for the ptrace system call which does it all for you.

Frank.

