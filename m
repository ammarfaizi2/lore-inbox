Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262452AbSJVKyd>; Tue, 22 Oct 2002 06:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262449AbSJVKy3>; Tue, 22 Oct 2002 06:54:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:10723 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S262447AbSJVKy1>;
	Tue, 22 Oct 2002 06:54:27 -0400
Date: Tue, 22 Oct 2002 13:00:32 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre11 No mouse
Message-ID: <20021022130032.D21346@ucw.cz>
References: <20021019083138.GA1753@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021019083138.GA1753@Master.Wizards>; from murrayr@brain.org on Sat, Oct 19, 2002 at 04:31:38AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 19, 2002 at 04:31:38AM -0400, Murray J. Root wrote:

> ASUS P4S533 (SiS645DX chipset)
> PS2 mouse & keyboard
> XFree86 Version 4.2.1
> GeForce2 GTS (with & without proprietary driver)
> 
> Mouse doesn't work (no response in X, no cursor in console with gpm).
> No error messages anywhere.

dmesg? /proc/bus/input/devices? ... 

-- 
Vojtech Pavlik
SuSE Labs
