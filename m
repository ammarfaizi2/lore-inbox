Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbTF2Vbr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Jun 2003 17:31:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264792AbTF2Vbr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Jun 2003 17:31:47 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:31751 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S264279AbTF2Vbn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Jun 2003 17:31:43 -0400
Date: Sun, 29 Jun 2003 23:45:58 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "David S. Miller" <davem@redhat.com>
Cc: alan@lxorguk.ukuu.org.uk, greearb@candelatech.com, mbligh@aracnet.com,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       netdev@oss.sgi.com
Subject: Re: networking bugs and bugme.osdl.org
Message-ID: <20030629214558.GA15089@win.tue.nl>
References: <3EFC9203.3090508@candelatech.com> <20030627.144426.71096593.davem@redhat.com> <1056755070.5463.12.camel@dhcp22.swansea.linux.org.uk> <20030629.141528.74734144.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030629.141528.74734144.davem@redhat.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 29, 2003 at 02:15:28PM -0700, David S. Miller wrote:

>    From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>    Date: 28 Jun 2003 00:04:30 +0100
>    
>    You are assuming there is a relationship in bug severity/commonness
>    and number of *developers* who hit it.
> 
> Not true, the assumption I make is that a bug report that
> a bug reporter cares about, and a patch that a patch submitter
> cares about, will all get resent if they get dropped.
> 
> If the reporter/submitter doesn't care, neither do I.

You are right, but only in the part where you say that this
is the best, indeed the only, way you can work.

Alan is right, information is important, and a lot of it is
submitted only once. (And a lot of it is submitted three times
and ignored three times.)

Suppose you find a gcc bug, construct a small example that
is mistranslated and send it off to the gcc list. Maybe even
include a fix. Will you babysit them, check whether later snapshots
correct this flaw, resubmit your report every month if not?
Maybe you will. I certainly don't - send the report and that's it.

Andries


