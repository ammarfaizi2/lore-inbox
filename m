Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315431AbSEGMiX>; Tue, 7 May 2002 08:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315432AbSEGMiW>; Tue, 7 May 2002 08:38:22 -0400
Received: from ns.suse.de ([213.95.15.193]:29957 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315431AbSEGMiU>;
	Tue, 7 May 2002 08:38:20 -0400
Date: Tue, 7 May 2002 14:38:19 +0200
From: Dave Jones <davej@suse.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Roman Zippel <zippel@linux-m68k.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.14 IDE 55
Message-ID: <20020507143818.N22215@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Martin Dalecki <dalecki@evision-ventures.com>,
	Roman Zippel <zippel@linux-m68k.org>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0205071345110.32715-100000@serv> <3CD7B826.7000000@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 07, 2002 at 01:19:02PM +0200, Martin Dalecki wrote:
 > Well one question renames: Please name me one PCI based architecture
 > which contains IDE support and does not contain any special host chip
 > attached to the very same PCI bus as well.

If by 'attached' you mean integrated into chipset, I have several such machines
that have no IDE without an extra add-on card.

My quad ppro has two PCI buses, but no IDE controller.
My PCI 486 has no onboard IDE.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
