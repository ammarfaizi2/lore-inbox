Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277703AbRJVTUu>; Mon, 22 Oct 2001 15:20:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277565AbRJVTUj>; Mon, 22 Oct 2001 15:20:39 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:4358 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S277703AbRJVTUa>;
	Mon, 22 Oct 2001 15:20:30 -0400
Date: Mon, 22 Oct 2001 12:20:54 -0700
From: Greg KH <greg@kroah.com>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: "Jeffrey H. Ingber" <axatax@thelittleman.net>,
        linux-kernel@vger.kernel.org
Subject: Re: USB module ov511 dies after about 30 minutes
Message-ID: <20011022122054.B4454@kroah.com>
In-Reply-To: <1003605486.1616.65.camel@eleusis> <200110211405.QAA01146@webserver.ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200110211405.QAA01146@webserver.ithnet.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 21, 2001 at 04:05:38PM +0100, Stephan von Krawczynski wrote:
> Is there anybody actively checking the drivers for availability of new
> versions? We obviously cannot trust on the authors themselves to      
> commit them, may not be their fault or even job. Who is to do that in 
> current maintaining actions?

It's up to the driver's authors to push updates through the proper
channels to keep the in kernel versions up to date.

In this case, go pester mmcclell@bigfoot.com to get him to send in a
patch to the USB maintainer.

thanks,

greg k-h
