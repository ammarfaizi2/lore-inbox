Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263246AbTANOuu>; Tue, 14 Jan 2003 09:50:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263256AbTANOut>; Tue, 14 Jan 2003 09:50:49 -0500
Received: from home.wiggy.net ([213.84.101.140]:10976 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S263246AbTANOut>;
	Tue, 14 Jan 2003 09:50:49 -0500
Date: Tue, 14 Jan 2003 15:59:41 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: IPMI
Message-ID: <20030114145941.GH606@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030114084011.6AB412C466@lists.samba.org> <3E241ECD.6000108@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E241ECD.6000108@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Corey Minyard wrote:
> config IPMI_HANDLER
>       tristate 'IPMI top-level message handler'
>       help
>         This enables the central IPMI message handler, required for IPMI
>         to work.  Note that you must have this enabled to enable any
>         other IPMI things.  IPMI is a standard for managing sensors
>         (temperature, voltage, etc.) in a system.  If you don't know
>         what it is, your system probably doesn't have it and you can
>         ignore this option.  See Documentation/IPMI.txt for more
>         details on the driver.

With modern systems it is quite likely that the system does have IPMI
but the user has no idea wat IPMI is.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
