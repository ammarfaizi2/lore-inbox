Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132462AbRDUDEc>; Fri, 20 Apr 2001 23:04:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132465AbRDUDEW>; Fri, 20 Apr 2001 23:04:22 -0400
Received: from mail1.panix.com ([166.84.0.212]:61401 "HELO mail1.panix.com")
	by vger.kernel.org with SMTP id <S132462AbRDUDEQ>;
	Fri, 20 Apr 2001 23:04:16 -0400
Date: Fri, 20 Apr 2001 20:54:16 -0600
From: Jeff Lightfoot <jeffml@pobox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Athlon problem report summary
Message-ID: <20010420205416.A229@panix.com>
Reply-To: jeffml@pobox.com
In-Reply-To: <fa.fkfenov.14jqeov@ifi.uio.no> <E14p894-00009E-00@the-village.bc.nu> <fa.fn57bnv.nno4p4@ifi.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <fa.fn57bnv.nno4p4@ifi.uio.no>; from lkml@sigkill.net on Fri, Apr 20, 2001 at 11:56:55PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Disconnect wrote:
> Addendum to 1. So far everyone (at least on LKML) who has had the
> crash-immediatly-do-not-pass-go issues has been using an iwill kk266 (or
> kk266r, IIRC) mobo.
> 
> Have we gotten any fix, other than not using K7 optimizations?

I think it has something to do with the BIOS version also.  The
original January KK266 BIOS can use K7 optimizations, but any BIOS
after that crashes hard.

-- 
Jeff Lightfoot   --    jeffml at pobox.com   --   http://thefoots.com/
