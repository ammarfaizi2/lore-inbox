Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262466AbTCMQgi>; Thu, 13 Mar 2003 11:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262471AbTCMQgi>; Thu, 13 Mar 2003 11:36:38 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:9860 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S262466AbTCMQgg>;
	Thu, 13 Mar 2003 11:36:36 -0500
Date: Thu, 13 Mar 2003 17:47:08 +0100
From: Jens Axboe <axboe@suse.de>
To: Willy Gardiol <gardiol@libero.it>
Cc: James Stevenson <james@stev.org>,
       Stephan von Krawczynski <skraw@ithnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: OOPS in 2.4.21-pre5, ide-scsi
Message-ID: <20030313164708.GJ836@suse.de>
References: <20030227221017.4291c1f6.skraw@ithnet.com> <014b01c2e978$701050e0$0cfea8c0@ezdsp.com> <20030313163707.GH836@suse.de> <200303131739.39991.gardiol@libero.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200303131739.39991.gardiol@libero.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 13 2003, Willy Gardiol wrote:
> Do you thnik this can have somthing to share with the oops i am
> getting with ide-scsi, a cd burner, DMA, and a PCI IDE controller?  I
> attach the oops decoded.
> 
> There is a thread about this on linux-ide, it seems a problem common
> at least to another guy

Looks very similar, indeed.

-- 
Jens Axboe

