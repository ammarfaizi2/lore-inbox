Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315416AbSEQEfm>; Fri, 17 May 2002 00:35:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315417AbSEQEfl>; Fri, 17 May 2002 00:35:41 -0400
Received: from rj.SGI.COM ([192.82.208.96]:7657 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S315416AbSEQEfk>;
	Fri, 17 May 2002 00:35:40 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: Adam Kropelin <akropel1@rochester.rr.com>
Cc: linux-kernel@vger.kernel.org, davej@suse.de
Subject: Re: [RFC][PATCH] cpqarray-1: Convert to modern module_init mechanism 
In-Reply-To: Your message of "Thu, 16 May 2002 20:51:46 -0400."
             <20020517005146.GA32719@www.kroptech.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 17 May 2002 14:35:27 +1000
Message-ID: <8562.1021610127@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 May 2002 20:51:46 -0400, 
Adam Kropelin <akropel1@rochester.rr.com> wrote:
>Below is a patch (against 2.5.15-dj1) to convert cpqarray over to the modern
>module_init mechanism. This eliminates the need to call cpqarray_init() from
>genhd.c and starts the process of simplifying the cpqarray init sequence.

The module related changes look OK, cannot speak for the rest of the
code changes.

