Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268477AbRGXVlS>; Tue, 24 Jul 2001 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268479AbRGXVlI>; Tue, 24 Jul 2001 17:41:08 -0400
Received: from ohiper1-3.apex.net ([209.250.47.18]:39693 "EHLO
	hapablap.dyn.dhs.org") by vger.kernel.org with ESMTP
	id <S268477AbRGXVk4>; Tue, 24 Jul 2001 17:40:56 -0400
Date: Tue, 24 Jul 2001 16:40:14 -0500
From: Steven Walter <srwalter@yahoo.com>
To: "Paul G. Allen" <pgallen@randomlogic.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Winbond Support
Message-ID: <20010724164014.A5801@hapablap.dyn.dhs.org>
In-Reply-To: <3B5DEACE.B4C794ED@randomlogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B5DEACE.B4C794ED@randomlogic.com>; from pgallen@randomlogic.com on Tue, Jul 24, 2001 at 02:38:22PM -0700
X-Uptime: 4:37pm  up 2 days,  1:05,  0 users,  load average: 1.27, 1.10, 1.08
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tue, Jul 24, 2001 at 02:38:22PM -0700, Paul G. Allen wrote:
> Does the Linux kernel (or any add-ons) support the Winbond W83782D Harware Monitoring chip? This is the chip that is on the Tyan K7 Thunder board.
> 
> PGA

Yes, it is quite well supported by the lm_sensors project, which is a
patch to the Linux kernel.  See here:

http://www.netroedge.com/~lm78/
-- 
-Steven
In a time of universal deceit, telling the truth is a revolutionary act.
			-- George Orwell
