Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274634AbRJEXoA>; Fri, 5 Oct 2001 19:44:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274633AbRJEXnu>; Fri, 5 Oct 2001 19:43:50 -0400
Received: from marine.sonic.net ([208.201.224.37]:18032 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S274627AbRJEXnm>;
	Fri, 5 Oct 2001 19:43:42 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 5 Oct 2001 16:44:08 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.11-pre4/drivers/mtd/bootldr.c does not compile
Message-ID: <20011005164408.A5469@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011005231732.B19985@flint.arm.linux.org.uk>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 05, 2001 at 11:17:32PM +0100, Russell King wrote:
> Firstly, its ARM only.  Secondly, Compaq decided that a partition table in

Can it be set up so that the MTD stuff only shows up for ARM and not for
x86?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
