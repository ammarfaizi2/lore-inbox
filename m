Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288575AbSAYWjh>; Fri, 25 Jan 2002 17:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288460AbSAYWj1>; Fri, 25 Jan 2002 17:39:27 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:41997 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S288432AbSAYWjT>; Fri, 25 Jan 2002 17:39:19 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: patch: sysctl.h (allocating new number)
Date: 25 Jan 2002 14:38:48 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a2smpo$23l$1@cesium.transmeta.com>
In-Reply-To: <3C51146F.6774.15F75C@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <3C51146F.6774.15F75C@localhost>
By author:    "Ulrich Windl" <Ulrich.Windl@rz.uni-regensburg.de>
In newsgroup: linux.dev.kernel
> 
> I have implemented sysctl extensions to read/write the ``tick'' and 
> slew rate of adjtime() (among others) for my new kernel clock model 
> using nanoseconds (PPSkit-2.0.1). If there's demand to a back-merge to 
> the main stream sources, plese say what you would like. As the project 
> was sponsored a little bit recently, I'm willing to donate a few 
> working hours for that.
> 

I, for one, would definitely see the clock model merged into the
mainstream kernel.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
