Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261854AbREVPIO>; Tue, 22 May 2001 11:08:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261851AbREVPIE>; Tue, 22 May 2001 11:08:04 -0400
Received: from mail.zmailer.org ([194.252.70.162]:12559 "EHLO zmailer.org")
	by vger.kernel.org with ESMTP id <S261837AbREVPHs>;
	Tue, 22 May 2001 11:07:48 -0400
Date: Tue, 22 May 2001 18:07:36 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: David Relson <relson@osagesoftware.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Final Warning [ was: ECN is on! ]
Message-ID: <20010522180736.L5947@mea-ext.zmailer.org>
In-Reply-To: <20010522131031.C5947@mea-ext.zmailer.org> <15114.18990.597124.656559@pizda.ninka.net> <3B0A7523.8641A688@sgi.com> <4.3.2.7.2.20010522105643.00d1d380@mail.osagesoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4.3.2.7.2.20010522105643.00d1d380@mail.osagesoftware.com>; from relson@osagesoftware.com on Tue, May 22, 2001 at 10:57:34AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Folks, don't speculate.  You are late anyway.

  We just had ECN off for two hours, and all sites which didn't
  commit harakiri at their firewalls ("bad TCP frame from that address,
  I will place that source into dead list") now either got their message,
  or are having some long-term troubles which might anyway get them
  kicked out after a few days time.
  (Long-term troubles meaning things where my solaris 2.6 machine can't
   reach those sites/servers.  D'uh...)

/Matti Aarnio


On Tue, May 22, 2001 at 10:57:34AM -0400, David Relson wrote:
> I'd suggest something like:
> 
> Final Warning.  ECN is being turned on NOW.  If your firewall doesn't 
> support ECN, this will be the last message that gets through to you from us.
> 
> Such a message will have the interesting characteristic of being the last 
> message received.  This will make it obvious why no further messages are 
> arriving.
> 
> David
> 
> --------------------------------------------------------
> David Relson                   Osage Software Systems, Inc.
> relson@osagesoftware.com       Ann Arbor, MI 48103
> www.osagesoftware.com          tel:  734.821.8800
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
