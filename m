Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262479AbTCMRbc>; Thu, 13 Mar 2003 12:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262482AbTCMRbc>; Thu, 13 Mar 2003 12:31:32 -0500
Received: from mail.ithnet.com ([217.64.64.8]:40199 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S262479AbTCMRbb>;
	Thu, 13 Mar 2003 12:31:31 -0500
Date: Thu, 13 Mar 2003 18:41:07 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jens Axboe <axboe@suse.de>
Cc: james@stev.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-Id: <20030313184107.7490b1fa.skraw@ithnet.com>
In-Reply-To: <20030313173717.GN836@suse.de>
References: <20030227221017.4291c1f6.skraw@ithnet.com>
	<014b01c2e978$701050e0$0cfea8c0@ezdsp.com>
	<20030313163707.GH836@suse.de>
	<016c01c2e980$b2d4ee60$0cfea8c0@ezdsp.com>
	<20030313164617.GI836@suse.de>
	<017e01c2e983$865e9bd0$0cfea8c0@ezdsp.com>
	<20030313173717.GN836@suse.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Mar 2003 18:37:17 +0100
Jens Axboe <axboe@suse.de> wrote:

> On Thu, Mar 13 2003, Stephan von Krawczynski wrote:
> > On Thu, 13 Mar 2003 18:14:26 +0100
> > Jens Axboe <axboe@suse.de> wrote:
> > 
> > > Ok, please reproduce in 2.4.21-pre5, its end_request handling is a lot
> > > different. If you just want a one-liner, I'd suggest trying something
> > > ala this on 2.4.20 and see if it makes any difference:
> > 
> > Please read my subject ;-)
> 
> Sorry, was there a clean oops from 2.4.21-pre5 posted? If so, please
> follow the suggestions I sent to James and provide me with the
> objdump output.

Sorry, yes there was (first posting of this thread). And there already is a
working patch on -pre5 in another branch of this thread. Please have a look ...

-- 
Regards,
Stephan

