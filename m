Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261206AbSK3WQW>; Sat, 30 Nov 2002 17:16:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261218AbSK3WQW>; Sat, 30 Nov 2002 17:16:22 -0500
Received: from panda.sul.com.br ([200.219.150.4]:13317 "EHLO ns.sul.com.br")
	by vger.kernel.org with ESMTP id <S261206AbSK3WQW>;
	Sat, 30 Nov 2002 17:16:22 -0500
Date: Sat, 30 Nov 2002 20:19:42 -0200
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>,
       ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       Andrew Grover <andrew.grover@intel.com>
Subject: Re: 2.5.50: echo > /proc/acpi/sleep b0rken
Message-ID: <20021130221942.GA5038@cathedrallabs.org>
References: <20021130194934.GA141@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021130194934.GA141@elf.ucw.cz>
From: aris@cathedrallabs.org (aris)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe this is needed, otherwise echo > /proc/acpi/sleep does not
> work. I'm not 200% sure this is correct fix, through, and it
> definitely needs to be fixed at *way* more places.
my mistake. i'll fix it and submit asap

-- 
aris
