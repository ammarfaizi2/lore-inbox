Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267241AbTBDMER>; Tue, 4 Feb 2003 07:04:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267242AbTBDMER>; Tue, 4 Feb 2003 07:04:17 -0500
Received: from ns.suse.de ([213.95.15.193]:3848 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267241AbTBDMER>;
	Tue, 4 Feb 2003 07:04:17 -0500
Date: Tue, 4 Feb 2003 13:13:48 +0100
From: Dave Jones <davej@suse.de>
To: Dominik Brodowski <linux@brodo.de>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       cpufreq@www.linux.org.uk
Subject: Re: [PATCH 2.5.59] cpufreq: support for "target frequency governors"
Message-ID: <20030204131348.C16744@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Dominik Brodowski <linux@brodo.de>, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
References: <20030203221443.GA1420@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20030203221443.GA1420@brodo.de>; from linux@brodo.de on Mon, Feb 03, 2003 at 11:14:43PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 11:14:43PM +0100, Dominik Brodowski wrote:
 > This patch adds support for "cpufreq governors". 
 > <snip excellent description of governors>

Could you add your descriptions to Documentation/cpufreq/ too?
The cpufreq interface has come quite a way since the original version
and is getting quite complex. Keeping documentation around for it
can only be a good thing, and as you've already written it.. 8-)

        Dave

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
