Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287003AbSABWAE>; Wed, 2 Jan 2002 17:00:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285006AbSABV74>; Wed, 2 Jan 2002 16:59:56 -0500
Received: from marine.sonic.net ([208.201.224.37]:25696 "HELO marine.sonic.net")
	by vger.kernel.org with SMTP id <S286853AbSABV7m>;
	Wed, 2 Jan 2002 16:59:42 -0500
X-envelope-info: <dalgoda@ix.netcom.com>
Date: Wed, 2 Jan 2002 13:59:39 -0800
From: Mike Castle <dalgoda@ix.netcom.com>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102215939.GA29462@thune.mrc-home.com>
Reply-To: Mike Castle <dalgoda@ix.netcom.com>
Mail-Followup-To: Mike Castle <dalgoda@ix.netcom.com>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102163043.A16513@thyrsus.com> <Pine.LNX.4.33.0201022247470.427-100000@Appserv.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0201022247470.427-100000@Appserv.suse.de>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 02, 2002 at 10:48:28PM +0100, Dave Jones wrote:
> Given that 'dmidecode' works fine in those circumstances, that's still
> not a convincing argument imo.

Except that is still has to run as root.

Granted, this stuff is static, so running it once at boot to create a table
that could be used by scripts could be useful.

mrc
-- 
     Mike Castle      dalgoda@ix.netcom.com      www.netcom.com/~dalgoda/
    We are all of us living in the shadow of Manhattan.  -- Watchmen
fatal ("You are in a maze of twisty compiler features, all different"); -- gcc
