Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262897AbUCKAUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 19:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262907AbUCKAUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 19:20:49 -0500
Received: from fw.osdl.org ([65.172.181.6]:40645 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262897AbUCKASx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 19:18:53 -0500
Date: Wed, 10 Mar 2004 16:16:46 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Peter Williams <peterw@aurema.com>
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org,
       Amarendra.Godbole@ge.com
Subject: Re: (0 == foo), rather than (foo == 0)
Message-Id: <20040310161646.2062f009.rddunlap@osdl.org>
In-Reply-To: <404F9E28.4040706@aurema.com>
References: <905989466451C34E87066C5C13DDF034593392@HYDMLVEM01.e2k.ad.ge.com>
	<20040310100215.1b707504.rddunlap@osdl.org>
	<Pine.LNX.4.53.0403101324120.18709@chaos>
	<404F9E28.4040706@aurema.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004 10:00:56 +1100 Peter Williams wrote:

| Richard B. Johnson wrote:
| > On Wed, 10 Mar 2004, Randy.Dunlap wrote:
| > 
| > 
| >>On Wed, 10 Mar 2004 11:46:40 +0530 Godbole, Amarendra \(GE Consumer &
| >>Industrial\) wrote:
| >>
| >>Hi,
| >>
| >>While writing code, the assignment operator (=) is many-a-times
| >>confused with the comparison operator (==) resulting in very subtle
| >>bugs difficult to track. To keep a check on this -- the constant
| >>can be written on the LHS rather than the RHS which will result
| >>in a compile time error if wrong operator is used.
| >>
| > 
| > 
| > People who develop kernel code know the difference between
| > '==' and '=' and are never confused my them.
| 
| And you never make typing mistakes?  That's admirable or should I say 
| incredible.

Whoa.  stop the presses.  an on-$subejct posting.

Please, let's kill all the other fuss about email crapola...

--
~Randy
