Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280803AbRKGOM4>; Wed, 7 Nov 2001 09:12:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280799AbRKGOMq>; Wed, 7 Nov 2001 09:12:46 -0500
Received: from femail7.sdc1.sfba.home.com ([24.0.95.87]:57244 "EHLO
	femail7.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S280800AbRKGOMd>; Wed, 7 Nov 2001 09:12:33 -0500
From: David Megginson <david@megginson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15337.16719.669560.795605@megginson.com>
Date: Wed, 7 Nov 2001 09:12:31 -0500
To: Massimo Dal Zotto <dz@cs.unitn.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: i8kutils
In-Reply-To: <200111071242.fA7CgmcY001822@dizzy.dz.net>
In-Reply-To: <15336.42604.800408.258987@megginson.com>
	<200111071242.fA7CgmcY001822@dizzy.dz.net>
X-Mailer: VM 6.92 under 21.5  (beta2) "artichoke" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Massimo Dal Zotto writes:

 > I use a small shell script which reads the current volume and changes
 > it incrementally. As explained in the manpage you should specify your
 > own commands with the command-line options, for example:
 > 
 >   i8kbuttons -u "aumix -v +10" -d "aumix -v -10" -m "aumix -v 0"

Thanks.  I'm using something like this now, but I was hoping to find a
program that could toggle the mute rather than just dropping the
volume to 0.  I'll figure out a work-around.


All the best,


David

-- 
David Megginson
david@megginson.com

