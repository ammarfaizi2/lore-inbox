Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290753AbSBOUDi>; Fri, 15 Feb 2002 15:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290754AbSBOUD2>; Fri, 15 Feb 2002 15:03:28 -0500
Received: from ns.suse.de ([213.95.15.193]:13584 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S290753AbSBOUDP>;
	Fri, 15 Feb 2002 15:03:15 -0500
Date: Fri, 15 Feb 2002 21:03:13 +0100
From: Dave Jones <davej@suse.de>
To: Wayne Whitney <whitney@math.berkeley.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.4-dj2
Message-ID: <20020215210313.G27880@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Wayne Whitney <whitney@math.berkeley.edu>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20020215172431.A32369@suse.de> <200202151957.g1FJvTL02935@adsl-209-76-109-63.dsl.snfc21.pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200202151957.g1FJvTL02935@adsl-209-76-109-63.dsl.snfc21.pacbell.net>; from whitney@math.berkeley.edu on Fri, Feb 15, 2002 at 11:57:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 15, 2002 at 11:57:29AM -0800, Wayne Whitney wrote:
 > patch-2.5.4-dj2 is missing the file include/sound/version.h, which is
 > present in patch-2.5.5-pre1.  The ALSA drivers won't compile without
 > it.  Even though that file says:

 This baffled me for a minute, as the file is here locally,
 then it hit me.

 version.h is in my diff exclusion list.

 Thanks for spotting that.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
