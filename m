Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270748AbRIAOja>; Sat, 1 Sep 2001 10:39:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270758AbRIAOjK>; Sat, 1 Sep 2001 10:39:10 -0400
Received: from cpe-24-221-114-147.az.sprintbbd.net ([24.221.114.147]:23687
	"EHLO localhost.digitalaudioresources.org") by vger.kernel.org
	with ESMTP id <S270748AbRIAOjF>; Sat, 1 Sep 2001 10:39:05 -0400
Message-ID: <3B90F310.1030808@digitalaudioresources.org>
Date: Sat, 01 Sep 2001 07:39:12 -0700
From: David Hollister <david@digitalaudioresources.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.3) Gecko/20010808
X-Accept-Language: en-us
MIME-Version: 1.0
To: Jim Roland <jroland@roland.net>
CC: Jan Niehusmann <jan@gondor.com>, linux-kernel@vger.kernel.org
Subject: Re: Athlon doesn't like Athlon optimisation?
In-Reply-To: <20010831044247.B811@gondor.com> <3B8EFF67.9010409@digitalaudioresources.org> <001101c132cd$cbbf7050$bb1cfa18@JimWS>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Roland wrote:
> Which kernel are you gentlemen using?  I have a Athlon 1.2GHz (not
> overclocked), 512MB PC133, and also an EPoX 8KTA3+, and have had no problems
> whatsoever (using kernel 2.4.2-2).

I'm on 2.4.9.  No overclocking.  I applied the patch that somebody (sorry, 
forgot who) posted yesterday for arch/i386/lib/mmx.c and rebuilt the kernel with 
Athlon optimization.  It now works.
-- 
David Hollister
Driversoft Engineering:  http://devicedrivers.com
Digital Audio Resources: http://digitalaudioresources.org

