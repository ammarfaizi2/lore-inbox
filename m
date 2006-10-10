Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030269AbWJJUPi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030269AbWJJUPi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 16:15:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030270AbWJJUPi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 16:15:38 -0400
Received: from mga07.intel.com ([143.182.124.22]:3866 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030269AbWJJUPh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 16:15:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,291,1157353200"; 
   d="scan'208"; a="129295555:sNHT77253582"
Message-ID: <452BFEFB.1090402@foo-projects.org>
Date: Tue, 10 Oct 2006 13:13:47 -0700
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Martin Naskovski <skopje@freeshell.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Intel 965 chipset motherboards + SATA
References: <Pine.NEB.4.62.0610101918540.24206@norge.freeshell.org>
In-Reply-To: <Pine.NEB.4.62.0610101918540.24206@norge.freeshell.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 10 Oct 2006 20:15:34.0193 (UTC) FILETIME=[D7916A10:01C6ECA8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Naskovski wrote:
> I have an ASUS P5B Deluxe/Core 2 Duo/Intel 965/all SATA (Plextor DVD+ 
> Seagate HD) configuration setup - and as of now, no distribution out 
> there can install on this configuration.
> 
> Information on whether this issue has been fixed is, at best, dubious on 
> various Linux forums.
> 
> /Does/ the Linux kernel support this configuration? Can it 
> install/recognize this hardware configuration?

sure, I'm running one right here =D

> I'm sorry to ask this question here, but all I need is a correct answer 
> - I've never posted here to ask questions, but this issue has been 
> bugging me quite a bit.

Distro's are struggling to catch up with the flood of new drivers since 2.6.18rc that 
support these new chipsets.

You'll probably install just fine on IDE first and switch to a manually compiled kernel 
(2.6.18 recommended) afterwards. Once the distro's catch up you'll have forgotten all 
the pain :)

Cheers,

Auke
