Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312381AbSC3EFU>; Fri, 29 Mar 2002 23:05:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312382AbSC3EFK>; Fri, 29 Mar 2002 23:05:10 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:56081 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S312381AbSC3EFB>;
	Fri, 29 Mar 2002 23:05:01 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: "Jeremy Jackson" <jerj@coplanar.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [QUESTION] which kernel debugger is "best"? 
In-Reply-To: Your message of "Fri, 29 Mar 2002 18:38:50 -0800."
             <010b01c1d794$07c7c9b0$7e0aa8c0@bridge> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 30 Mar 2002 15:04:49 +1100
Message-ID: <2344.1017461089@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Mar 2002 18:38:50 -0800, 
"Jeremy Jackson" <jerj@coplanar.net> wrote:
>What are people using?  neither kdb or kgdb appear to support
>2.5.7 (kdb does 2.5.5)... or do real men debug with prink() ?

I just uploaded kdb patches for 2.5.7 to
ftp://oss.sgi.com/projects/kdb/download/v2.1.  They compile but have not
been booted, I don't have much time to work on 2.5 kernels.  I have no
idea if it will work with a preemptible kernel or not.

