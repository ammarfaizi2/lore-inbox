Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264334AbTDKLfN (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 07:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264335AbTDKLfN (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 07:35:13 -0400
Received: from mail.ithnet.com ([217.64.64.8]:7949 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S264334AbTDKLfM (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 07:35:12 -0400
Date: Fri, 11 Apr 2003 13:39:08 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: alan@lxorguk.ukuu.org.uk, 76306.1226@compuserve.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges
Message-Id: <20030411133908.5f28a721.skraw@ithnet.com>
In-Reply-To: <524390000.1049993090@aslan.btc.adaptec.com>
References: <200304082124_MC3-1-3399-FBD0@compuserve.com>
	<1049886804.9901.19.camel@dhcp22.swansea.linux.org.uk>
	<194120000.1049909641@aslan.btc.adaptec.com>
	<20030410132055.1745749c.skraw@ithnet.com>
	<524390000.1049993090@aslan.btc.adaptec.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Apr 2003 10:44:50 -0600
"Justin T. Gibbs" <gibbs@scsiguy.com> wrote:

> > As I am probably one of the victims of these differing opinions, can anyone
> > tell me where to get a really-known-to-work aic-driver for 2.4? I am
> > experiencing zapping-black events while reading from a SDLT drive (writing
> > to it does fine).
> 
> The best way to get to a resolution on aic7xxx issues is to use the
> drivers from here:
> 
> http://people.FreeBSD.org/~gibbs/linux/SRC/

Ok, I tried this one on top of 2.4.21-pre6 (can't compile -pre7) and had to
find out, that it freezes on X startup. I have never experienced something like
that before.
Anything I can do/test? There is no oops, just freeze (screen does not turn
black, kdm freezes in the middle of the startup, displays window borders but no
images).

-- 
Regards,
Stephan
