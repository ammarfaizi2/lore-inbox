Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030501AbVKCVhn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030501AbVKCVhn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 16:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030504AbVKCVhn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 16:37:43 -0500
Received: from hell.sks3.muni.cz ([147.251.210.189]:57272 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S1030501AbVKCVhn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 16:37:43 -0500
Date: Thu, 3 Nov 2005 22:37:09 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Nathan Scott <nathans@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Large file system oddities
Message-ID: <20051103213709.GJ2507@mail.muni.cz>
References: <20051103190334.GI2507@mail.muni.cz> <20051104081959.C6290773@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20051104081959.C6290773@wobbly.melbourne.sgi.com>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2005 at 08:19:59AM +1100, Nathan Scott wrote:
> Why?  Just use /dev/sdc directly, and you'll avoid the 32 bit
> problems fdisk (or the default partition table type, I can't
> remember which it is now) evidently has.
> 
> Try without the partition, looks like that'll work.

Yes, this one works ok. I can see 3.2TB of free space. Thanks.

-- 
Luká¹ Hejtmánek
