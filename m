Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278629AbRJSTfT>; Fri, 19 Oct 2001 15:35:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278627AbRJSTe7>; Fri, 19 Oct 2001 15:34:59 -0400
Received: from marine.sonic.net ([208.201.224.37]:16401 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S278625AbRJSTez>;
	Fri, 19 Oct 2001 15:34:55 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 19 Oct 2001 12:35:23 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Cc: Mike Castle <dalgoda@ix.netcom.com>
Subject: Re: e2fsck, LVM and 4096-char block problems
Message-ID: <20011019123523.A10770@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011019132513.F402@turbolinux.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 19, 2001 at 01:25:13PM -0600, Andreas Dilger wrote:
> On Oct 19, 2001  11:59 -0700, Mike Castle wrote:
> > Using Linus' 2.4.10, unpatched.  (Perhaps I need to patch the LVM stuff ;-)
> 
> Very bad combination.  Don't use 2.4.10, don't use stock Linus LVM.

I hadn't built 2.4.12 yet.

What needs to be done to get recent LVM into stock kernel?

I feel like it's the 2.2 RAID stuff all over again.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
