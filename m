Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263701AbTHZM0R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 08:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263776AbTHZM0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 08:26:16 -0400
Received: from holomorphy.com ([66.224.33.161]:2991 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263701AbTHZM0N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 08:26:13 -0400
Date: Tue, 26 Aug 2003 05:27:11 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: M?ns Rullg?rd <mru@users.sourceforge.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Strange memory usage reporting
Message-ID: <20030826122711.GS4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	M?ns Rullg?rd <mru@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
References: <yw1xad9w1uj5.fsf@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yw1xad9w1uj5.fsf@users.sourceforge.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 26, 2003 at 02:18:54PM +0200, M?ns Rullg?rd wrote:
> I was a little surprised to see top tell me this:
>   PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND           
> 10642 mru       11   0 23200  81m 2740 S  0.0 37.0   0:00.07 tcvp              
> It didn't make sense that RES > VIRT, so I check /proc/pid/*.  Their
> contents are below.  Am I missing something?  Note that they are not
> consistent with the 'top' line above, since they were copied at a
> different time.  The effect is easily reproducible.  It happens every
> time I run my music player with using ALSA.
> The memory usage summary by top, also doesn't agree:

What kernel version?


-- wli
