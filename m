Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265597AbTGDAx5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jul 2003 20:53:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbTGDAx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jul 2003 20:53:56 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:45841 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S265597AbTGDAxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jul 2003 20:53:55 -0400
Date: Thu, 3 Jul 2003 18:08:08 -0700
From: jw schultz <jw@pegasys.ws>
To: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.74-mm1 with contest
Message-ID: <20030704010808.GB9719@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>
References: <200307040132.55827.kernel@kolivas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200307040132.55827.kernel@kolivas.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 04, 2003 at 01:32:55AM +1000, Con Kolivas wrote:
> Here are contest benchmarks for 2.5.74-mm1 with my scheduler tweaks:
> 
[snip]
> 
> A little more here, a little less there. No major changes except for dbench 
> load which appears to have significantly shorter compile times. As kernel 
> compiles are not by their nature "interactive", these results are expected. 
> It is nice to see that it doesn't appear to starve any load unecessarily as 
> well. 
> 
> Contest can show the kernel's ability to perform in the setting of different 
> loads without being choked, but will not show if your audio application will 
> get to play when it wants to, nor whether your windows will move around the 
> screen smoothly.
> 
> Con
> 
> P.S. Does anyone see the irony in the fact that my own benchmark won't show 
> that my patch does anything?

I see no irony, and much value, in your benchmark showing
that your patch doesn't break server performance.

Perhaps a load that generated X events to move a window
around in an ellipse or polygon would show some effects of
your patch.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
