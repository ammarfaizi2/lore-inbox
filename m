Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWAWPKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWAWPKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 10:10:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbWAWPKE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 10:10:04 -0500
Received: from amdext3.amd.com ([139.95.251.6]:1239 "EHLO amdext3.amd.com")
	by vger.kernel.org with ESMTP id S1751464AbWAWPKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 10:10:01 -0500
X-Server-Uuid: 89466532-923C-4A88-82C1-66ACAA0041DF
Date: Mon, 23 Jan 2006 08:06:21 -0700
From: "Jordan Crouse" <jordan.crouse@amd.com>
To: "Dan Malek" <dan@embeddedalley.com>
cc: "Ralf Baechle" <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
       alsa-devel@alsa-project.org, "Adrian Bunk" <bunk@stusta.de>,
       perex@suse.cz, linux-mips@linux-mips.org
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060123150621.GE4371@cosmic.amd.com>
References: <20060119174600.GT19398@stusta.de>
 <20060121210511.GD3456@linux-mips.org>
 <2edd3641fe1cb18d25e35abe40de5d4e@embeddedalley.com>
MIME-Version: 1.0
In-Reply-To: <2edd3641fe1cb18d25e35abe40de5d4e@embeddedalley.com>
User-Agent: Mutt/1.5.11
X-WSS-ID: 6FCA2F3A1HW274478-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/01/06 09:11 -0500, Dan Malek wrote:
> 
> On Jan 21, 2006, at 4:05 PM, Ralf Baechle wrote:
> 
> >On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:
> >
> >>3. no ALSA drivers for the same hardware
> >[...]
> >>SOUND_AU1550_AC97
> 
> The Au1550 should have an ALSA driver.  It was done
> some time ago.  Perhaps we just didn't submit it to the
> proper maintainer.  I'll track that down.

My official position is that I would prefer an ALSA driver if exists.

Jordan

-- 
Jordan Crouse
Senior Linux Engineer
AMD - Personal Connectivity Solutions Group
<www.amd.com/embeddedprocessors>

