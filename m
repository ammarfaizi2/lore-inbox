Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751161AbWATV3V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751161AbWATV3V (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 16:29:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750781AbWATV3V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 16:29:21 -0500
Received: from cantor2.suse.de ([195.135.220.15]:7560 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751161AbWATV3U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 16:29:20 -0500
Date: Fri, 20 Jan 2006 22:29:17 +0100
From: Olaf Hering <olh@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different approach
Message-ID: <20060120212917.GA14405@suse.de>
References: <20060119174600.GT19398@stusta.de> <20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20060120190415.GM19398@stusta.de>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Fri, Jan 20, Adrian Bunk wrote:

 
> Can someone from the ppc developers drop me a small note whether 
> SND_POWERMAC completely replaces DMASOUND_PMAC?

It doesnt. Some tumbler models work only after one plug/unplug cycle of
the headphone. early powerbooks report/handle the mute settings
incorrectly. there are likely more bugs.

-- 
short story of a lazy sysadmin:
 alias appserv=wotan
