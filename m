Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261583AbSJMS5g>; Sun, 13 Oct 2002 14:57:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261585AbSJMS5f>; Sun, 13 Oct 2002 14:57:35 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:7698
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261583AbSJMS5f>; Sun, 13 Oct 2002 14:57:35 -0400
Subject: Re: Evolution and 2.5.x
From: Robert Love <rml@tech9.net>
To: Eric Blade <eblade@m-net.arbornet.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200210131854.g9DIs1I0062874@m-net.arbornet.org>
References: <200210131854.g9DIs1I0062874@m-net.arbornet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 13 Oct 2002 15:03:23 -0400
Message-Id: <1034535804.6032.4501.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-10-13 at 14:54, Eric Blade wrote:

>   I'm guessing that not too many of the kernel developers use Evolution as
> their email program :)   Since I started picking up the 2.5.x series, at around
> 2.5.34, Evolution does not run anywhere near properly.  I'm not sure if that
> is a kernel issue, or a problem with Evolution's code..  But it did improve
> quite a bit with all the low-level process management that was in the 2.5.3x 
> series.  It still doesn't work right though.  (in 2.5.34, evolution would
> just plain halt the system ... in 2.5.42, it mostly works right, as long
> as you don't try to compose a message.. composing a message will leave you
> with a whole buch of zombie processes). 

Hey, I use Evolution ;-)

See this thread:
http://lists.ximian.com/archives/public/evolution-hackers/2002-June/004841.html

It is indeed broken in 2.5 and it is not, for once, our fault.  This
thread and other discussion seem to point out it is a bug in ORBit.

	Robert Love

