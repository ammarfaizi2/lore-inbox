Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265410AbSJaWI5>; Thu, 31 Oct 2002 17:08:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265398AbSJaWI4>; Thu, 31 Oct 2002 17:08:56 -0500
Received: from waste.org ([209.173.204.2]:38366 "EHLO waste.org")
	by vger.kernel.org with ESMTP id <S265412AbSJaWIP>;
	Thu, 31 Oct 2002 17:08:15 -0500
Date: Thu, 31 Oct 2002 16:14:39 -0600
From: Oliver Xymoron <oxymoron@waste.org>
To: george anzinger <george@mvista.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: lost messages
Message-ID: <20021031221438.GJ3620@waste.org>
References: <3DC1A983.7B5B12B2@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC1A983.7B5B12B2@mvista.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 31, 2002 at 02:06:59PM -0800, george anzinger wrote:
> I just stepped over the line again with a message too long
> for the lklm.  Am I the only one who would like a message
> back when lklm drops a message?  The mail system seems to
> say:
> relay=vger.kernel.org. [209.116.70.75], 
> stat=Sent (2.7.0 nothing apparently wrong in the message.;
> S264820AbSJaKoJ)
> 
> and then drop the message.  Maybe, at least this response
> could be changed.

Your message makes it to majordomo's resend code and gets bounced to
owner, which is probably not much different from /dev/null. It'd be
possible to add bounce notifications, but it'd be a big ugly hack on
top of a long-dead codebase, work better invested in switching to a
new list manager.

-- 
 "Love the dolphins," she advised him. "Write by W.A.S.T.E.." 
