Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264614AbTDZGUW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Apr 2003 02:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264620AbTDZGUW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Apr 2003 02:20:22 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35346 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S264614AbTDZGUV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Apr 2003 02:20:21 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: 9-track tape drive (Was: Re: versioned filesystems in linux)
Date: 25 Apr 2003 23:32:02 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8d952$162$1@cesium.transmeta.com>
References: <3EA9A72F.4030505@zytor.com> <Pine.LNX.4.33.0304251729490.18442-100000@router.windsormachine.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0304251729490.18442-100000@router.windsormachine.com>
By author:    Mike Dresser <mdresser_l@windsormachine.com>
In newsgroup: linux.dev.kernel
>
> On Fri, 25 Apr 2003, H. Peter Anvin wrote:
> 
> > actually measure the real speed you can presumably vary the speed
> > arbitrarily, all the way up to the breaking point of the medium.
> 
> I suspect that method is patented, as I have seen this implemented on
> both Travan tapes, and cassette tapes.
> 
> However, there seems to have been a flaw in the implementation, where the
> breaking point was underestimated.
> 

Presumably any patents on this have since long expired (they would
have had to have been filed no earlier than 1983.)

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
