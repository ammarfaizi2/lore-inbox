Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289326AbSAVSB7>; Tue, 22 Jan 2002 13:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289314AbSAVSBu>; Tue, 22 Jan 2002 13:01:50 -0500
Received: from ns.suse.de ([213.95.15.193]:44296 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S289290AbSAVSBb>;
	Tue, 22 Jan 2002 13:01:31 -0500
Date: Tue, 22 Jan 2002 19:01:29 +0100
From: Dave Jones <davej@suse.de>
To: Robert Schwebel <robert@schwebel.de>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] AMD Elan patch
Message-ID: <20020122190129.A21203@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Robert Schwebel <robert@schwebel.de>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0112311900380.3056-100000@callisto.local> <Pine.LNX.4.33.0201221545350.21377-100000@callisto.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201221545350.21377-100000@callisto.local>; from robert@schwebel.de on Tue, Jan 22, 2002 at 03:47:32PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2002 at 03:47:32PM +0100, Robert Schwebel wrote:
 > 
 > I have another patch from Sven Geggus in the pipeline which makes it
 > possible to change the CPU's clock frequency on the fly.

 It would probably be a good idea to make this fit the cpufreq
 API that Russell King, myself and a few others created.
 It's in the ARM Linux CVS with the modulename cpufreq.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
