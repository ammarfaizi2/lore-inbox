Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277893AbRJISkS>; Tue, 9 Oct 2001 14:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277894AbRJISkI>; Tue, 9 Oct 2001 14:40:08 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:36615 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277893AbRJISjy>; Tue, 9 Oct 2001 14:39:54 -0400
X-Apparently-From: <trever?adams@yahoo.com>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
From: "Trever L. Adams" <trever_adams@yahoo.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110091129190.209-100000@desktop>
In-Reply-To: <Pine.LNX.4.33.0110091129190.209-100000@desktop>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 14:40:40 -0400
Message-Id: <1002652844.3356.1.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 14:31, Jeffrey W. Baker wrote:
> I mean connections originating from userland processes running on the
> machine with iptables configured.  This machine does not act as a NAT or
> router for any other machine.
> 
> We make about 200000 outbound connections to web sites in a day.  Of these
> connections, a few thousand get fucked up by iptables (iptables suddenly
> decides to drop packets on this connection).
> 
> -jwb

Mine does NAT.  So it appears this is not NAT related (though it may be
further aggravated by NAT).  My connection rate is FAR lower than
yours.  Our total connections may be 100,000 on a high rate day (just a
guess... I really do not know).

Interesting.

Trever Adams


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

