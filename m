Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283016AbRLDXjG>; Tue, 4 Dec 2001 18:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283597AbRLDXi5>; Tue, 4 Dec 2001 18:38:57 -0500
Received: from user-119a3cr.biz.mindspring.com ([66.149.13.155]:61704 "HELO
	fancypants.trellisinc.com") by vger.kernel.org with SMTP
	id <S283016AbRLDXii>; Tue, 4 Dec 2001 18:38:38 -0500
Date: Tue, 4 Dec 2001 18:38:37 -0500
From: Faux Pas III <fauxpas@trellisinc.com>
To: linux-kernel@vger.kernel.org
Subject: Re: PM + Maestro weirdness
Message-ID: <20011204183837.A429@trellisinc.com>
In-Reply-To: <20011204182724.A356@trellisinc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011204182724.A356@trellisinc.com>; from fauxpas@trellisinc.com on Tue, Dec 04, 2001 at 06:27:24PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 04, 2001 at 06:27:24PM -0500, Faux Pas III wrote:

> This state persists until reboot.

Actually, putting the laptop to sleep (apm -s) and waking it back
up will allow the module to be inserted again (once).

-- 
Josh Litherland (fauxpas@trellisinc.com)
 It is by caffeine alone that I set my mind in motion.
  It is by the juice of Mtn Dew that thoughts acquire speed.
