Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263295AbSJCNuO>; Thu, 3 Oct 2002 09:50:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263296AbSJCNuN>; Thu, 3 Oct 2002 09:50:13 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:31240 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263295AbSJCNuM>; Thu, 3 Oct 2002 09:50:12 -0400
Date: Thu, 3 Oct 2002 14:55:18 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: DevilKin <devilkin-lkml@blindguardian.org>
Cc: jbradford@dial.pipex.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Bodge up serial support in 2.5.40
Message-ID: <20021003145518.G2304@flint.arm.linux.org.uk>
References: <200210021636.g92GaWEp000312@darkstar.example.net> <200210021837.39020.devilkin-lkml@blindguardian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200210021837.39020.devilkin-lkml@blindguardian.org>; from devilkin-lkml@blindguardian.org on Wed, Oct 02, 2002 at 06:37:38PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 02, 2002 at 06:37:38PM +0200, DevilKin wrote:
> On Wednesday 02 October 2002 18:36, jbradford@dial.pipex.com wrote:
> > Standard 8250/16550 UART support is broken in 2.5.40, and I needed it, so
> > following a bit of advice from Russell King, I've prepared this patch.
> >
> 
> Actually, they work fine in 2.5.40. Well, my serial mouse works fine. So i 
> guess the serial port must work fine too.

Its certain compilation options that mess it up atm.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

