Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266010AbSKFTiz>; Wed, 6 Nov 2002 14:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266015AbSKFTiy>; Wed, 6 Nov 2002 14:38:54 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11281 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266010AbSKFTiy>; Wed, 6 Nov 2002 14:38:54 -0500
Date: Wed, 6 Nov 2002 19:45:28 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: linux-kernel@vger.kernel.org
Subject: Re: dmesg of 2.5.45 boot on NFS client
Message-ID: <20021106194528.C7495@flint.arm.linux.org.uk>
Mail-Followup-To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
	linux-kernel@vger.kernel.org
References: <200211061605.gA6G5xp14090@Port.imtp.ilyichevsk.odessa.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200211061605.gA6G5xp14090@Port.imtp.ilyichevsk.odessa.ua>; from vda@port.imtp.ilyichevsk.odessa.ua on Wed, Nov 06, 2002 at 06:57:45PM -0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 06:57:45PM -0200, Denis Vlasenko wrote:
> Serial: 8250/16550 driver $Revision: 1.90 $ IRQ sharing disabled
> tts/%d0 at I/O 0x3f8 (irq = 4) is a 16550A
>     ^^

Already killed.  I think it went in just after 2.5.46 was released.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

