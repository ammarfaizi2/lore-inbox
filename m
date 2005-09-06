Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932261AbVIFCKE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932261AbVIFCKE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 22:10:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932281AbVIFCKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 22:10:03 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:49927 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S932261AbVIFCKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 22:10:00 -0400
Date: Mon, 5 Sep 2005 22:10:18 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Mathieu <matt@minas-morgul.org>
cc: Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Brand-new notebook useless with Linux...
In-Reply-To: <87psrn6d04.fsf@barad-dur.minas-morgul.org>
Message-ID: <Pine.LNX.4.61.0509052157190.31857@lancer.cnet.absolutedigital.net>
References: <200509031859_MC3-1-A720-F705@compuserve.com>
 <87psrn6d04.fsf@barad-dur.minas-morgul.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Sep 2005, Mathieu wrote:

> the bioses released by phoenix seem a little broken. try a 2.6.13
> kernel with the option ec_burst=1.

I agree with the broken phoenix part but be careful playing with ec_burst. 
When it was set to default pre-2.6.13-rc6 it caused my laptop to overheat 
and trip the thermal shutdown on several occasions before I figured out 
what the hell was going on (the fan wasn't getting spun when needed).

good luck,
-cp

-- 
". . . tell 'em we use Linux." -- Dave Chappelle

