Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267631AbUBTAsH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Feb 2004 19:48:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267609AbUBTAqZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Feb 2004 19:46:25 -0500
Received: from pacific.moreton.com.au ([203.143.235.130]:30225 "EHLO
	dorfl.internal.moreton.com.au") by vger.kernel.org with ESMTP
	id S267598AbUBTAkq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Feb 2004 19:40:46 -0500
Message-ID: <403557C0.9060603@snapgear.com>
Date: Fri, 20 Feb 2004 10:41:36 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: linux-2.6.3-uc0 (MMU-less fixups)
References: <40342BD5.9080105@snapgear.com> <20040219103900.GH17140@khan.acc.umu.se> <4034B2E5.1090505@snapgear.com> <20040219131317.GI17140@khan.acc.umu.se> <40355080.8090008@snapgear.com> <20040220001524.GL17140@khan.acc.umu.se>
In-Reply-To: <20040220001524.GL17140@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

David Weinehall wrote:
>>>How's the status of the 2.0-port of uClinux, btw?  Is it unintrusive
>>>enough to be considered for a 2.0-merge?
>>
>>Hmm, probably not. It is no where near as clean as the 2.6
>>merge. It could be cleaned up, but no one seems to interrested
>>in doing the work.
> 
> 
> Well, if there are users and interest, I could do at least some of the
> work.  Since I've already done some work with 2.0 uClinux, and since I'm
> the 2.0 maintainer, I do have some experience ;-)

There are still users. I was planning on merging in your 2.0.40
code sometime soon, to bring the uClinux 2.0 sources up to date
at the very least. But if you feel like doing it, that would be
good too :-)

Regards
Greg




------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
SnapGear -- a CyberGuard Company            PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com

