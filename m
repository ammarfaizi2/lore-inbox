Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266208AbUHMQpY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266208AbUHMQpY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 12:45:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHMQpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 12:45:23 -0400
Received: from fw.osdl.org ([65.172.181.6]:41422 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266208AbUHMQpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 12:45:17 -0400
Date: Fri, 13 Aug 2004 09:22:30 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Cc: linux-kernel@vger.kernel.org
Subject: Re: epoll, aio  etc...
Message-Id: <20040813092230.68c81a00.rddunlap@osdl.org>
In-Reply-To: <121364952.20040813180657@dns.toxicfilms.tv>
References: <121364952.20040813180657@dns.toxicfilms.tv>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Aug 2004 18:06:57 +0200 Maciej Soltysiak wrote:

| Hi,
| 
| where would you recomend looking for tutorials on using
| new 2.6 goodies like epoll, aio, and others. Tutorials
| that would include an introduction, code examples, etc.
| 
| I have been trying to find some but with no good results.

I haven't seen tutorials for epoll or aio.  Have you already
looked at these?

http://www.xmailserver.org/linux-patches/nio-improve.html
http://lse.sourceforge.net/epoll/index.html
http://epoll.hackerdojo.com/


or at some aio testing code:
http://developer.osdl.org/daniel/AIO/
http://developer.osdl.org/daniel/AIO/TESTS/

Chris Mason (SuSE/Novell) also has an aio stress tester iirc.
Try searching for it.

Bill Irwin (wli) did an aio/epoll presentation at OLS 2004.
I don't know where to find it, though.

--
~Randy
