Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277797AbRJIWAE>; Tue, 9 Oct 2001 18:00:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278004AbRJIV7z>; Tue, 9 Oct 2001 17:59:55 -0400
Received: from smtp011.mail.yahoo.com ([216.136.173.31]:54797 "HELO
	smtp011.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S277797AbRJIV7w>; Tue, 9 Oct 2001 17:59:52 -0400
X-Apparently-From: <trever?adams@yahoo.com>
Subject: Re: iptables in 2.4.10, 2.4.11pre6 problems
From: "Trever L. Adams" <trever_adams@yahoo.com>
To: "Jeffrey W. Baker" <jwbaker@acm.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0110091348010.15092-100000@windmill.gghcwest.com>
In-Reply-To: <Pine.LNX.4.33.0110091348010.15092-100000@windmill.gghcwest.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.15.99+cvs.2001.10.05.08.08 (Preview Release)
Date: 09 Oct 2001 18:00:43 -0400
Message-Id: <1002664845.3360.8.camel@aurora>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-10-09 at 16:48, Jeffrey W. Baker wrote:
> > Mine does NAT.  So it appears this is not NAT related (though it may be
> > further aggravated by NAT).  My connection rate is FAR lower than
> > yours.  Our total connections may be 100,000 on a high rate day (just a
> > guess... I really do not know).
> 
> My machine has three IP addrs bound to one physical interface and uses
> policy routing.  Do you use any of those?
> 
> -jwb

Two IP addresses.  One to the internal ethernet, one to the external
(dynamic ip) ppp.  I do not believe I am doing policy routing.  I have
the static route for ethernet and ppp sets up its own.

Trever


_________________________________________________________
Do You Yahoo!?
Get your free @yahoo.com address at http://mail.yahoo.com

