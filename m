Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbTBGPmW>; Fri, 7 Feb 2003 10:42:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265880AbTBGPmW>; Fri, 7 Feb 2003 10:42:22 -0500
Received: from pcp01184434pcs.strl301.mi.comcast.net ([68.60.187.197]:42168
	"EHLO mythical") by vger.kernel.org with ESMTP id <S265424AbTBGPmU>;
	Fri, 7 Feb 2003 10:42:20 -0500
Date: Fri, 7 Feb 2003 10:51:44 -0500
From: Ryan Anderson <ryan@michonline.com>
To: "Peter C. Norton" <spacey-linux-kernel@lenin.nu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5.59 morse code panics
Message-ID: <20030207155144.GD13861@michonline.com>
Mail-Followup-To: "Peter C. Norton" <spacey-linux-kernel@lenin.nu>,
	linux-kernel@vger.kernel.org
References: <20030131154141.GH12286@louise.pinerecords.com> <200301311601.h0VG159O001744@darkstar.example.net> <20030204060007.GD16814@lenin.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204060007.GD16814@lenin.nu>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2003 at 10:00:07PM -0800, Peter C. Norton wrote:
> On Fri, Jan 31, 2003 at 04:01:05PM +0000, John Bradford wrote:
> > Especially since a number of Linux developers have ham radio
> > experience.
> 
> Well most linux users don't.  I'm sure its really easy to find a morse
> code chart in many hundreds of places online.  But 2 scripts - one
> that turns keyboard input or mic input into dots and dashes (so you
> can enter it yourself or put the phone up to the system's microphone)
> would help.  Then all you'd need is a morse->ascii converter.
> 
> So who's got a good morse->ascii program?  And who has the
> dot-dash->.-.-.- translator?  And the audio->.-.-.- translator?

emacs (I'm not a user, though) has something like M-x-morse that will
convert back and forth.

Otherwise, the basic tables are fairly easy to find - I've seen multiple
filters for various IRC clients that would convert in at least one
direction.

In any case, there are two things to remember here:
	1) This may occassionaly be helpful in debugging problems.
	2) It has a nice hack value to it.

> 
> -Peter
> 
> -- 
> The 5 year plan:
> In five years we'll make up another plan.
> Or just re-use this one.
> 
> Plan 2: If you're going to apologize, don't do it.  If you're going to 
> do it, don't apologize
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 

Ryan Anderson
  sometimes Pug Majere
