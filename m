Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278393AbRJMUMC>; Sat, 13 Oct 2001 16:12:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278391AbRJMULy>; Sat, 13 Oct 2001 16:11:54 -0400
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:46596 "EHLO
	bug.ucw.cz") by vger.kernel.org with ESMTP id <S278390AbRJMULq>;
	Sat, 13 Oct 2001 16:11:46 -0400
Message-ID: <20011012230104.A3069@bug.ucw.cz>
Date: Fri, 12 Oct 2001 23:01:04 +0200
From: Pavel Machek <pavel@suse.cz>
To: Jacques Gelinas <jack@solucorp.qc.ca>,
        Linux kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Announce: many virtual servers on a single box
In-Reply-To: <20011011010632.e0c6a94f1bc2@remtk.solucorp.qc.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20011011010632.e0c6a94f1bc2@remtk.solucorp.qc.ca>; from Jacques Gelinas on Thu, Oct 11, 2001 at 01:06:32AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> -I have also modified the capability system a little, so those virtual server
>  administrators can't take over the machine. I have introduced a per-process
>  capability ceiling, inherited by sub-process. Even setuid program can't grab
>  more capabilities..

Really? What hardware do they see in /dev/? Do their servers have for
example mouse? What about ethernet cards?

Does /proc/kmem work in virtual servers?

[Why I'm asking? I'm trying to find ways to take over the machine. Do
you want to give me root on your machine stating that I can't
interfere?]

You might want to announce this on bugtraq. [And give solar designer
root account, he might be more creative ;)].

								Pavel
-- 
STOP THE WAR! Someone killed innocent Americans. That does not give
U.S. right to kill people in Afganistan.


