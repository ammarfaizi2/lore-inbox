Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264034AbUEXV5e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264034AbUEXV5e (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 17:57:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264379AbUEXV5e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 17:57:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:58020 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264034AbUEXV5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 17:57:32 -0400
Date: Mon, 24 May 2004 14:47:23 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [announce/OT] kerneltop ver. 0.7
Message-Id: <20040524144723.0db4cd2f.rddunlap@osdl.org>
In-Reply-To: <20040524053153.GM1833@holomorphy.com>
References: <20040523215027.5dc99711.rddunlap@osdl.org>
	<20040524053153.GM1833@holomorphy.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 23 May 2004 22:31:53 -0700 William Lee Irwin III wrote:

| On Sun, May 23, 2004 at 09:50:27PM -0700, Randy.Dunlap wrote:
| > just a little note about kerneltop...
| > 'kerneltop' is similar to 'top', but shows only kernel function usage
| > (modules not included).
| > I have updated it a bit (now version 0.7) and made sure that it
| > works OK on Linux 2.6.x.
| > It's available here:
| > 	http://www.xenotime.net/linux/kerneltop/
| 
| GRRR.. this tries to reset /proc/profile. Multiple megabytes of in-
| kernel memset() at a frequency of 1Hz are extremely unfriendly.

Looks nice.  Applied.

--
~Randy
