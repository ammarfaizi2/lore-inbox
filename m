Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278821AbRJVONO>; Mon, 22 Oct 2001 10:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278825AbRJVONE>; Mon, 22 Oct 2001 10:13:04 -0400
Received: from ns.ithnet.com ([217.64.64.10]:31755 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S278821AbRJVOMz>;
	Mon, 22 Oct 2001 10:12:55 -0400
Date: Mon, 22 Oct 2001 16:13:13 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB module ov511 dies after about 30 minutes
Message-Id: <20011022161313.358f278e.skraw@ithnet.com>
In-Reply-To: <Pine.LNX.4.30.0110221547290.11628-100000@Appserv.suse.de>
In-Reply-To: <20011022154537.53c54bf3.skraw@ithnet.com>
	<Pine.LNX.4.30.0110221547290.11628-100000@Appserv.suse.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.6.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Oct 2001 15:50:08 +0200 (CEST) Dave Jones <davej@suse.de> wrote:

> On Mon, 22 Oct 2001, Stephan von Krawczynski wrote:
> 
> > > > about 30 minutes the module ov511 cannot be unloaded anymore, stopped
> > > > working
> > Sorry, tested but does not work either. It even hangs the system sometimes.
Of
> > course it did with former kernels. Any other ideas?
> 
> Remind me, what kernel version was this ? Until 2.4.12 iirc usb-uhci had
> problems with ov511. Using the alternative uhci driver may also be
> something worth trying. Other than that, I'm out of ideas. USB gurus ?

Kernel is 2.4.13-pre5, will test pre6 this evening.

Regards,
Stephan

