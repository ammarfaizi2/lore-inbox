Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267439AbTB1CkV>; Thu, 27 Feb 2003 21:40:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267442AbTB1CkU>; Thu, 27 Feb 2003 21:40:20 -0500
Received: from are.twiddle.net ([64.81.246.98]:65443 "EHLO are.twiddle.net")
	by vger.kernel.org with ESMTP id <S267439AbTB1CkU>;
	Thu, 27 Feb 2003 21:40:20 -0500
Date: Thu, 27 Feb 2003 18:50:36 -0800
From: Richard Henderson <rth@twiddle.net>
To: Marc Zyngier <mzyngier@freesurf.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.63 : Fix Jensen compilation
Message-ID: <20030227185036.A23640@twiddle.net>
Mail-Followup-To: Marc Zyngier <mzyngier@freesurf.fr>,
	linux-kernel@vger.kernel.org
References: <wrpbs0xh436.fsf@hina.wild-wind.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <wrpbs0xh436.fsf@hina.wild-wind.fr.eu.org>; from mzyngier@freesurf.fr on Thu, Feb 27, 2003 at 09:16:13PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 09:16:13PM +0100, Marc Zyngier wrote:
> POSIX conformance testing by UNIFIX
> Machine check
> 
> ?06 DBL MCHK
>   PC= 00000000.00014421 PSL= 00000000.00000007

Fixed in http://linux-axp.bkbits.net/axp-2.5/.


r~
