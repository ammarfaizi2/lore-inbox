Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271741AbRJJAy3>; Tue, 9 Oct 2001 20:54:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271911AbRJJAyT>; Tue, 9 Oct 2001 20:54:19 -0400
Received: from [209.250.53.189] ([209.250.53.189]:47628 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S271741AbRJJAyG>; Tue, 9 Oct 2001 20:54:06 -0400
Date: Tue, 9 Oct 2001 19:54:39 -0500
From: Steven Walter <srwalter@yahoo.com>
To: Michael Peddemors <michael@wizard.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Framebuffer detection problems, 2.4.9
Message-ID: <20011009195439.B26019@hapablap.dyn.dhs.org>
Mail-Followup-To: Steven Walter <srwalter@yahoo.com>,
	Michael Peddemors <michael@wizard.ca>, linux-kernel@vger.kernel.org
In-Reply-To: <1002670696.4112.285.camel@mistress> <20011009192459.A26019@hapablap.dyn.dhs.org> <1002675326.4200.297.camel@mistress>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1002675326.4200.297.camel@mistress>; from michael@wizard.ca on Tue, Oct 09, 2001 at 05:55:26PM -0700
X-Uptime: 7:18pm  up 1 day,  8:44,  0 users,  load average: 0.38, 0.85, 0.94
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001 at 05:55:26PM -0700, Michael Peddemors wrote:
> Of course I have read /fb/vesafb.txt, as it show on the line above your
> response :) But I still get unknown mode id, no matter what I seem to
> do..
> Adding the 200 should result in 0x313, which is entered at the vga ask
> prompt as 0313, which is the mode for 800x600x32k colors, which is a
> nice low default for most video card/monitor combinations..  Otherwise I
> wouldn't have posted to LKML.... Any other reasons why we would get an
> 'Unknown mode ID'? 

You seem to be doing everything correctly... perhaps drop the leading
zero?
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
Freedom is slavery. Ignorance is strength. War is peace.
			-- George Orwell
Those that would give up a necessary freedom for temporary safety
deserver neither freedom nor safety.
			-- Ben Franklin
