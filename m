Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291038AbSBGXhP>; Thu, 7 Feb 2002 18:37:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291068AbSBGXhG>; Thu, 7 Feb 2002 18:37:06 -0500
Received: from ns.suse.de ([213.95.15.193]:12808 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291038AbSBGXgy>;
	Thu, 7 Feb 2002 18:36:54 -0500
Date: Fri, 8 Feb 2002 00:36:53 +0100
From: Dave Jones <davej@suse.de>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18-pre8-K2: Kernel panic: CPU context corrupt
Message-ID: <20020208003653.A28235@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Alex Riesen <fork0@users.sf.net>,
	linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20020208001831.A200@steel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020208001831.A200@steel>; from fork0@users.sf.net on Fri, Feb 08, 2002 at 12:18:31AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 08, 2002 at 12:18:31AM +0100, Alex Riesen wrote:
 
 > Feb  7 23:45:31 steel kernel: CPU 0: Machine Check Exception: 0000000000000004
 > Feb  7 23:45:31 steel kernel: Bank 4: b200000000040151
 > Feb  7 23:45:31 steel kernel: Kernel panic: CPU context corrupt

 Machine checks are indicative of hardware fault.
 Overclocking, inadequate cooling and bad memory are the usual causes.

 > P.S. no nasty suspections about processor, please. No funds reserved
 > for a new one :)

 The truth hurts 8(

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
