Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291948AbSCOM2b>; Fri, 15 Mar 2002 07:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292131AbSCOM2W>; Fri, 15 Mar 2002 07:28:22 -0500
Received: from ns.suse.de ([213.95.15.193]:46602 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S291948AbSCOM2F>;
	Fri, 15 Mar 2002 07:28:05 -0500
Date: Fri, 15 Mar 2002 13:28:03 +0100
From: Dave Jones <davej@suse.de>
To: darktim@darktim.dyndns.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Kernel does not boot with Machine Check Exeption
Message-ID: <20020315132803.B1661@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	darktim@darktim.dyndns.org, linux-kernel@vger.kernel.org
In-Reply-To: <1016190918.3c91d7c69aacd@darktim.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1016190918.3c91d7c69aacd@darktim.dyndns.org>; from darktim@darktim.dyndns.org on Fri, Mar 15, 2002 at 12:15:18PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 15, 2002 at 12:15:18PM +0100, darktim@darktim.dyndns.org wrote:
 > After I have upgraded mey Kernel from 2.4.19-pre2-ac4 to 2.4.19-pre3
 > the machine hangs while checking the CPU. 

 Back out the bluesmoke.c changes.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
