Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261168AbTD1Pa5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Apr 2003 11:30:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbTD1Pa5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Apr 2003 11:30:57 -0400
Received: from relay04.valueweb.net ([216.219.253.238]:2963 "EHLO
	relay04.valueweb.net") by vger.kernel.org with ESMTP
	id S261168AbTD1Pa4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Apr 2003 11:30:56 -0400
Message-ID: <3EAD4BF3.1090408@coyotegulch.com>
Date: Mon, 28 Apr 2003 11:42:43 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030327 Debian/1.3-4
X-Accept-Language: en
MIME-Version: 1.0
To: Takashi Iwai <tiwai@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.6x Sound frustration
References: <3EA9AC16.4070903@coyotegulch.com> <s5hr87myb6c.wl@alsa2.suse.de>
In-Reply-To: <s5hr87myb6c.wl@alsa2.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Takashi Iwai wrote:
 > if it's not the case, try to unmute and raise "Headphone" volume.
 > some devices use True LINEOUT as the wave lineout.

Apologies for a slightly misleading response a few minutes ago.

Raising the Headphone volume (with alsamixer) *did* solve my problem -- 
but only *after* I rebooted the system. I now have sound.

The previous e-mail contains the system information your requested.

Thanks.

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)
Professional programming for science and engineering;
Interesting and unusual bits of very free code.

