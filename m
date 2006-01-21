Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751411AbWAWMau@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751411AbWAWMau (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 07:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751423AbWAWMat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 07:30:49 -0500
Received: from mipsfw.mips-uk.com ([194.74.144.146]:14871 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1751412AbWAWMat (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 07:30:49 -0500
Date: Sat, 21 Jan 2006 21:05:11 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz,
       linux-mips@linux-mips.org
Subject: Re: RFC: OSS driver removal, a slightly different approach
Message-ID: <20060121210511.GD3456@linux-mips.org>
References: <20060119174600.GT19398@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060119174600.GT19398@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 06:46:00PM +0100, Adrian Bunk wrote:

> 3. no ALSA drivers for the same hardware
[...]
> SOUND_AU1550_AC97
[...]
> SOUND_IT8172
[...]
> SOUND_VRC5477

I'm already hammering the responsible people to rewrite the drivers for
ALSA since a while but slow progress.  The latter two platforms have no
active maintainers so I don't expect to see ALSA drivers.

  Ralf
