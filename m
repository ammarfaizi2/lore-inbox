Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSESP7B>; Sun, 19 May 2002 11:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314556AbSESP67>; Sun, 19 May 2002 11:58:59 -0400
Received: from ns.suse.de ([213.95.15.193]:49423 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S314529AbSESP6i>;
	Sun, 19 May 2002 11:58:38 -0400
Date: Sun, 19 May 2002 17:58:38 +0200
From: Dave Jones <davej@suse.de>
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: nVidia NIC/IDE/something support?
Message-ID: <20020519175838.I15417@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Roy Sigurd Karlsbakk <roy@karlsbakk.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <200205191514.g4JFEsV13608@mail.pronto.tv>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 19, 2002 at 05:14:54PM +0200, Roy Sigurd Karlsbakk wrote:
 > I just bought this Asus board, A7N266-VM, with nVidia IDE, LAN and god knows 
 > chipset. Linux doesn't understand it, and I really want it... Any plans of 
 > supporting this? See below for /proc/pci output.

It's an nForce chipset. To the best of my knowledge, there are no
public specs for this beast, so your only hope is probably to bug
nVidia.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
