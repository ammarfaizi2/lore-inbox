Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285963AbRLVAwi>; Fri, 21 Dec 2001 19:52:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286414AbRLVAw3>; Fri, 21 Dec 2001 19:52:29 -0500
Received: from marine.sonic.net ([208.201.224.37]:6254 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S286367AbRLVAwV>;
	Fri, 21 Dec 2001 19:52:21 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Fri, 21 Dec 2001 16:52:15 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17
Message-ID: <20011222005215.GC6619@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0112211744080.7492-100000@freak.distro.conectiva> <4.3.2.7.2.20011221193149.00ca6f00@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20011221193149.00ca6f00@mail.osagesoftware.com>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 21, 2001 at 07:34:29PM -0500, David Relson wrote:
> My thought is that the _only_ difference between the last -rc and -final is 
> correctly setting "EXTRAVERSION=" in Makefile.

Perhaps Documentation/* changes.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
