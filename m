Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292663AbSBUReq>; Thu, 21 Feb 2002 12:34:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292664AbSBUReh>; Thu, 21 Feb 2002 12:34:37 -0500
Received: from ns.suse.de ([213.95.15.193]:22021 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S292663AbSBUReW>;
	Thu, 21 Feb 2002 12:34:22 -0500
Date: Thu, 21 Feb 2002 18:34:20 +0100
From: Dave Jones <davej@suse.de>
To: Gregor Jasny <gjasny@wh8.tu-dresden.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.5 - Linking error
Message-ID: <20020221183420.L5583@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Gregor Jasny <gjasny@wh8.tu-dresden.de>, linux-kernel@vger.kernel.org
In-Reply-To: <200202211711.g1LHBYAH014952@backfire.WH8.TU-Dresden.De>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202211711.g1LHBYAH014952@backfire.WH8.TU-Dresden.De>; from gjasny@wh8.tu-dresden.de on Thu, Feb 21, 2002 at 06:11:34PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 21, 2002 at 06:11:34PM +0100, Gregor Jasny wrote:
 > drivers/net/net.o(.data+0xd4): undefined reference to `local symbols in 
 > discarded section .text.exit'
 > make[1]: *** [vmlinux] Error 1
 > make[1]: Leaving directory `/usr/src/linux-2.5.5'
 > What must I change that it links properly?

See 'Compile errors' in http://www.codemonkey.org.uk/Linux-2.5.html

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
