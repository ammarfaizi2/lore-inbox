Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265503AbRGEXKd>; Thu, 5 Jul 2001 19:10:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265548AbRGEXJN>; Thu, 5 Jul 2001 19:09:13 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:28723 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265562AbRGEXJD>;
	Thu, 5 Jul 2001 19:09:03 -0400
Message-ID: <20010706010855.B1956@win.tue.nl>
Date: Fri, 6 Jul 2001 01:08:55 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Aaron Lehmann <aaronl@vitelus.com>
Cc: Wakko Warner <wakko@animx.eu.org>, Stephen C Burns <sburns@farpointer.net>,
        linux-kernel@vger.kernel.org, 83710@bugs.debian.org
Subject: Re: [OT] Re: LILO calling modprobe?
In-Reply-To: <20010706010107.A1956@win.tue.nl> <20010705160332.A23273@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <20010705160332.A23273@vitelus.com>; from Aaron Lehmann on Thu, Jul 05, 2001 at 04:03:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 05, 2001 at 04:03:32PM -0700, Aaron Lehmann wrote:
> On Fri, Jul 06, 2001 at 01:01:07AM +0200, Guest section DW wrote:
> > But why don't you use the bios keyword? From lilo.conf(5):
> 
> It doesn't help.

Of course it does.

(But you must distinguish people. One complains about the probing,
another about the numbering. The bios keyword tells lilo about
the numbering, and it works.)
