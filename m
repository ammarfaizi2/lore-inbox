Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVBSAJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVBSAJJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 19:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261585AbVBSAJI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 19:09:08 -0500
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:20373 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S261578AbVBSAFl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 19:05:41 -0500
Message-ID: <421682CF.6020405@bigpond.net.au>
Date: Sat, 19 Feb 2005 11:05:35 +1100
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Peter Williams <pwil3058@bigpond.net.au>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>,
       Chris Han <xiphux@gmail.com>, Con Kolivas <kernel@kolivas.org>
Subject: Re: [ANNOUNCE][RFC] PlugSched-3.0 meets CKRM-E17
References: <420974BC.7080600@bigpond.net.au>
In-Reply-To: <420974BC.7080600@bigpond.net.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Williams wrote:
> A patch of PlugSched-3.0 against a 2.6.10 kernel with 
> ckrm-e17.2610.patch and cpu.ckrm-e17.v10.patch already applied is 
> available for download from:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-3.0%2Bckrm-E17-for-2.6.10.patch?download> 
> 
> 
> and a patchset and series file are available in at gzipped tarball at:
> 
> <http://prdownloads.sourceforge.net/cpuse/plugsched-3.0%2Bckrm-E17-for-2.6.10.patchset.tar.gz?download> 
> 
> 
> The model adopted in merging PlugSched with CKRM was to apply the CKRM 
> mechanisms as an optional adjunct to each of the schedulers (ingosched, 
> staircase, spa_no_frills and zaphod) which can be selected at boot time 
> by adding "cpusched=<scheduler name>" to the boot command line.  If the 
> CKRM scheduler is included in the build then it can be 
> selected/deselected in the usual ways.
> 
> PlugSched's version number has been bumped to 3.0 as its interface has 
> been modified to increase the ability to share code between schedulers 
> as well as integrate with CKRM.
> 
> A stand alone version of PlugSched-3.0 will be available in a few days.

Now available at:

<http://prdownloads.sourceforge.net/cpuse/plugsched-3.0-for-2.6.10.patch?download>

-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce
