Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135267AbRDZJrc>; Thu, 26 Apr 2001 05:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135266AbRDZJrX>; Thu, 26 Apr 2001 05:47:23 -0400
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:36272 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S135264AbRDZJrD>; Thu, 26 Apr 2001 05:47:03 -0400
Date: Thu, 26 Apr 2001 11:47:00 +0200
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: 2.4.3 tinny module interface cleanum
Message-ID: <20010426114700.A679@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3AE7E346.731E19FA@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <3AE7E346.731E19FA@evision-ventures.com>; from dalecki@evision-ventures.com on Thu, Apr 26, 2001 at 10:58:46AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 10:58:46AM +0200, Martin Dalecki wrote:
> 1. Help making the module interface cleaner by a tinny margin :-).

You only help changing the API during a stable[1] series. Wait until 2.5
for this.

API cannot change during stable series. (ABI can, BTW)

So lets just forget about this, ok ;-)

Regards

Ingo Oeser

[1] By stable I mean "marked as the stable branch" not the actual
   behavior >;)
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
