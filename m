Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272676AbTHOTQS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 15:16:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272681AbTHOTQR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 15:16:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:45720 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S272676AbTHOTQO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 15:16:14 -0400
Date: Fri, 15 Aug 2003 12:12:40 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: peter@chubb.wattle.id.au, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [PATCH] Fix loose->lose typos in 2.6.0-test2
Message-Id: <20030815121240.7ff9fed0.rddunlap@osdl.org>
In-Reply-To: <20030815184720.A65182CE83@lists.samba.org>
References: <20030815184720.A65182CE83@lists.samba.org>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Aug 2003 03:12:52 +1000 Rusty Russell <rusty@rustcorp.com.au> wrote:

| > 
| > I cringe every time I see `loose' used where `lose' is intended.
| > Here's a fix for the few that escaped the attentions of the spelling mafia...
| 
| Me too, however...
| 
| After a brief conversation with Andrew, Trivial Patch Monkey is only
| taking patches for documentation and where grep might be effected.
| Feel free to push this directly though.

then it qualifies.
Who would grep for 'loose' when it should be 'lose' and v.v.?

--
~Randy
