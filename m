Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbUKDVbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbUKDVbw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 16:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262427AbUKDVbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 16:31:52 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:53636 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262420AbUKDVbt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 16:31:49 -0500
Message-ID: <418AA075.3070303@tmr.com>
Date: Thu, 04 Nov 2004 16:34:45 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
Newsgroups: mail.linux-kernel
To: John McGowan <jmcgowan@inch.com>
CC: Dave Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel 2.6.9: i810 video
References: <21d7e99704110314156bb270de@mail.gmail.com><20041102215308.GA3579@localhost.localdomain> <20041103234045.G92772@shell.inch.com>
In-Reply-To: <20041103234045.G92772@shell.inch.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McGowan wrote:
> On Thu, 4 Nov 2004, Dave Airlie wrote:

>>What chipset have you got?
> 
> 
> An HP 7850 - various motherboards used ... this one has an
> e-machine motherboard. Bios has no controls for the video
> chip. Does FW82810E sound line the chipset? It is mentioned
> somewhere in the motherboard doc I found on some site (not HP's
> so it may or may not be correct).

I think the output of 'lspci' posted here will provide the information.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
