Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262821AbRE3Vx3>; Wed, 30 May 2001 17:53:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262823AbRE3VxU>; Wed, 30 May 2001 17:53:20 -0400
Received: from marine.sonic.net ([208.201.224.37]:65106 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S262821AbRE3Vvr>;
	Wed, 30 May 2001 17:51:47 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 30 May 2001 14:44:14 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ln -s broken on 2.4.5
Message-ID: <20010530144414.I24802@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010530233005.A27497@caldera.de>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 11:30:05PM +0200, Marcus Meissner wrote:
> The problem is only there if you specify a directory for the linked to
> component.
> 
> [marcus@wine /tmp]$ strace -f ln -s fupp/berk xxx

Is it only a directory, or the length?

ln -s fupp_berk xxx 

for instance.
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
