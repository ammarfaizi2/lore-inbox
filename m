Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262945AbREaBCu>; Wed, 30 May 2001 21:02:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262949AbREaBCk>; Wed, 30 May 2001 21:02:40 -0400
Received: from marine.sonic.net ([208.201.224.37]:2369 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S262945AbREaBCX>;
	Wed, 30 May 2001 21:02:23 -0400
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 30 May 2001 18:02:07 -0700
From: Mike Castle <dalgoda@ix.netcom.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How to know HZ from userspace?
Message-ID: <20010530180207.M24802@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <p0510031ab73b43e89d24@[10.128.7.49]>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2001 at 05:44:39PM -0700, Jonathan Lundell wrote:
> Lots. Maybe we oughta have /proc/sysconf/... (there's no reason 
> sysconf() can't be a library reading /proc).

You don't mount proc?

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
