Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261426AbTAXRyx>; Fri, 24 Jan 2003 12:54:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261427AbTAXRyx>; Fri, 24 Jan 2003 12:54:53 -0500
Received: from gate.in-addr.de ([212.8.193.158]:40712 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S261426AbTAXRyx>;
	Fri, 24 Jan 2003 12:54:53 -0500
Date: Fri, 24 Jan 2003 19:02:55 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Kevin Lawton <kevinlawton2001@yahoo.com>, Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Simple patches for Linux as a guest OS in a plex86 VM (please consider)
Message-ID: <20030124180255.GF1099@marowsky-bree.de>
References: <20030124154935.GB20371@elf.ucw.cz> <20030124171415.34636.qmail@web80310.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030124171415.34636.qmail@web80310.mail.yahoo.com>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2003-01-24T09:14:15,
   Kevin Lawton <kevinlawton2001@yahoo.com> said:

> To get any level of security with UML, you need to use "jailed mode"
> in which performance takes a big beating.  To fix this, you need
> patches to Linux as a host, to make it offer a better environment
> for running UML guests.  From a commercial perspective, then you have
> a patched Linux host + totally different port of a Linux guest.

That commercial perspective is then completely misguided.

All alternatives I have seen to UML (plex, vmware, UMLinux) suck IMHO. They
are inherently much more platform specific than UML. The necessary
modifications on the host for UML ska mode are minimal and I think besides
bashing out whether it should be a syscall, proc file or whatever, everybody
seems pretty much set on integrating them into the kernel.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
