Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265542AbRGEX3m>; Thu, 5 Jul 2001 19:29:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265562AbRGEX3d>; Thu, 5 Jul 2001 19:29:33 -0400
Received: from vitelus.com ([64.81.36.147]:35602 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id <S265542AbRGEX30>;
	Thu, 5 Jul 2001 19:29:26 -0400
Date: Thu, 5 Jul 2001 16:29:06 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Guest section DW <dwguest@win.tue.nl>
Cc: Wakko Warner <wakko@animx.eu.org>, Stephen C Burns <sburns@farpointer.net>,
        linux-kernel@vger.kernel.org, 83710@bugs.debian.org
Subject: Re: [OT] Re: LILO calling modprobe?
Message-ID: <20010705162906.A23834@vitelus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010706010855.B1956@win.tue.nl>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 06, 2001 at 01:08:55AM +0200, Guest section DW wrote:
> (But you must distinguish people. One complains about the probing,
> another about the numbering. The bios keyword tells lilo about
> the numbering, and it works.)

Well, shouldn't lilo avoid probing if you pass bios=? Currently it
doesn't.
