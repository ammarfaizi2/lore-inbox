Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSKTXpa>; Wed, 20 Nov 2002 18:45:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262387AbSKTXpa>; Wed, 20 Nov 2002 18:45:30 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:45700 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S264936AbSKTXoI>; Wed, 20 Nov 2002 18:44:08 -0500
Subject: Re: Linux 2.2.23-rc2
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87wun796m3.fsf@deneb.enyo.de>
References: <200211201628.gAKGSwL03853@devserv.devel.redhat.com> 
	<87wun796m3.fsf@deneb.enyo.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Nov 2002 00:19:53 +0000
Message-Id: <1037837993.3702.106.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-11-20 at 23:14, Florian Weimer wrote:
> Alan Cox <alan@redhat.com> writes:
> 
> > Actually include the DoS fix this time
> 
> But doesn't seem to include the TCP "SYN with RST isn't a SYN, really"
> fix. ;-)

I wasnt aware 2.2 had that problem. I'll take a look.

