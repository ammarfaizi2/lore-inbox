Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262451AbTCMR0n>; Thu, 13 Mar 2003 12:26:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262459AbTCMR0n>; Thu, 13 Mar 2003 12:26:43 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:16788 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262451AbTCMR0m>;
	Thu, 13 Mar 2003 12:26:42 -0500
Date: Thu, 13 Mar 2003 18:37:17 +0100
From: Jens Axboe <axboe@suse.de>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: james@stev.org, linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
       marcelo@conectiva.com.br
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-ID: <20030313173717.GN836@suse.de>
References: <20030227221017.4291c1f6.skraw@ithnet.com> <014b01c2e978$701050e0$0cfea8c0@ezdsp.com> <20030313163707.GH836@suse.de> <016c01c2e980$b2d4ee60$0cfea8c0@ezdsp.com> <20030313164617.GI836@suse.de> <017e01c2e983$865e9bd0$0cfea8c0@ezdsp.com> <20030313171426.GK836@suse.de> <20030313183139.27ebf082.skraw@ithnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313183139.27ebf082.skraw@ithnet.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, Stephan von Krawczynski wrote:
> On Thu, 13 Mar 2003 18:14:26 +0100
> Jens Axboe <axboe@suse.de> wrote:
> 
> > Ok, please reproduce in 2.4.21-pre5, its end_request handling is a lot
> > different. If you just want a one-liner, I'd suggest trying something
> > ala this on 2.4.20 and see if it makes any difference:
> 
> Please read my subject ;-)

Sorry, was there a clean oops from 2.4.21-pre5 posted? If so, please
follow the suggestions I sent to James and provide me with the
objdump output.

-- 
Jens Axboe

