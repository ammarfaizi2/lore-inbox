Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261596AbSJYUqo>; Fri, 25 Oct 2002 16:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261600AbSJYUqo>; Fri, 25 Oct 2002 16:46:44 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:22286 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S261596AbSJYUqn>; Fri, 25 Oct 2002 16:46:43 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: One for the Security Guru's
Date: 25 Oct 2002 13:52:27 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <apcaub$ov5$1@cesium.transmeta.com>
References: <1035453664.1035.11.camel@syntax.dstl.gov.uk> <ap97nr$h6e$1@forge.intermeta.de> <1035479086.9935.6.camel@gby.benyossef.com> <1035539042.23977.24.camel@forge>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <1035539042.23977.24.camel@forge>
By author:    Henning Schmiedehausen <hps@intermeta.de>
In newsgroup: linux.dev.kernel
> > 
> > A. If there's a buffer overflow in the SSL Accelerator box the firewall
> > wont do you much good (it helps, but only a little). 
> 
> This is a hardware device. Hardware as in "silicon". I very much doubt
> that you can run "general purpose programs" on a device specifically
> designed to do crypto. And this is _not_ just an "embedded Linux on ix86
> with a crypto chip". 
> 

Hardware devices have bugs, too.  Furthermore, most devices marketed
as "hardware" still have programmable stuff underneath.  Trust me.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
