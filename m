Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288432AbSAQJXe>; Thu, 17 Jan 2002 04:23:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288422AbSAQJXY>; Thu, 17 Jan 2002 04:23:24 -0500
Received: from upco.es ([130.206.70.227]:17528 "HELO mail1.upco.es")
	by vger.kernel.org with SMTP id <S288432AbSAQJXM>;
	Thu, 17 Jan 2002 04:23:12 -0500
Date: Thu, 17 Jan 2002 10:23:02 +0100
From: Romano Giannetti <romano@dea.icai.upco.es>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Power off NOT working, kernel 2.4.16
Message-ID: <20020117102302.A19119@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: Romano Giannetti <romano@dea.icai.upco.es>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <3C45F45C.5000005@mbnet.fi> <20020117134753.4330b0b5.sfr@canb.auug.org.au> <3C468109.3090401@mbnet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C468109.3090401@mbnet.fi>; from rzei@mbnet.fi on Thu, Jan 17, 2002 at 09:45:13AM +0200
X-Edited-With-Muttmode: muttmail.sl - 2000-11-20 - RGtti 2001-01-29
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 17, 2002 at 09:45:13AM +0200, Joonas Koivunen wrote:
> 
> Yes, it's there, and I have also tried poweroff, no effect, last text 
> line I see is 'Power down.' and the system is succefully halted, not 
> switched off.

I have the same problem on my home box (Athlon with AMD mo-bo). RedHat
compiled kernel _do_ poweroff (although with a flashing oops just before
power goes off), but none of vanillas kernel can do it --- I tried with and
without ACPI, with APM real-mode call, whatever. 

                     Romano

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 411 132
