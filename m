Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262139AbSJNTnQ>; Mon, 14 Oct 2002 15:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262141AbSJNTnP>; Mon, 14 Oct 2002 15:43:15 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:51206
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S262139AbSJNTnO>; Mon, 14 Oct 2002 15:43:14 -0400
Subject: Re: Evolution and 2.5.x
From: Robert Love <rml@tech9.net>
To: Thomas Molina <tmolina@cox.net>
Cc: Andy Pfiffer <andyp@osdl.org>, Eric Blade <eblade@m-net.arbornet.org>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0210141435440.6072-100000@dad.molina>
References: <Pine.LNX.4.44.0210141435440.6072-100000@dad.molina>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 14 Oct 2002 15:48:55 -0400
Message-Id: <1034624937.753.4718.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-14 at 15:41, Thomas Molina wrote:

> I've read this thread and I'm confused.  Is this seen as a problem with 
> Evolution, ORBit, or the 2.5 kernel?  If it is seen as a possible kernel 
> problem, I'll add it to my problem report status page and track it.  If I 
> track it, Eric Blade will get a weekly email asking whether he's still 
> seeing the problem, at least until I'm told to drop it, or no one 
> responds.

It is a problem with ORBit.

Behavior changed somewhere in the kernel - I think a return value is
different but was not standard before and ORBit relied on it.

	Robert Love

