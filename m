Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318526AbSHSL5C>; Mon, 19 Aug 2002 07:57:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318690AbSHSL5C>; Mon, 19 Aug 2002 07:57:02 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:57334 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S318526AbSHSL5B>; Mon, 19 Aug 2002 07:57:01 -0400
Subject: Re: max open file descriptors
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Sirius Black <sirius_ml@shellfreaks.cx>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <001101c2476c$75f0ca70$3b05420a@salabop2>
References: <001101c2476c$75f0ca70$3b05420a@salabop2>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 19 Aug 2002 13:01:10 +0100
Message-Id: <1029758470.19376.0.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-08-19 at 11:37, Sirius Black wrote:
> Hi to all,
> 
> I was wondering on how much the FD limit can be increased
> whitout having any problems; i've searched on the net and found 
> some docs which says 2048 and others 4096....
> 
> Which is the maximum number of open FD can i set?

For 2.2 there are real per process limitations, for 2.4 it basically
depends how much RAM you have

