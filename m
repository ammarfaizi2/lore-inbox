Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266970AbRGHUlY>; Sun, 8 Jul 2001 16:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266971AbRGHUlO>; Sun, 8 Jul 2001 16:41:14 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:10250 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S266970AbRGHUky>; Sun, 8 Jul 2001 16:40:54 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Machine check exception? (2.4.6+SMP+VIA)
Date: 8 Jul 2001 13:40:36 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <9iagg4$1dc$1@cesium.transmeta.com>
In-Reply-To: <20010708192805.C26213@weta.f00f.org> <NDBBKKONDOBLNCIOPCGHIEKOIKAA.vhou@khmer.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <NDBBKKONDOBLNCIOPCGHIEKOIKAA.vhou@khmer.cc>
By author:    "Vibol Hou" <vhou@khmer.cc>
In newsgroup: linux.dev.kernel
> 
> I also wonder, however, if this could be due to the 2nd processor not
> getting enough voltage.  I don't know the S-SPEC of the processor, but I
> think it's the same as the 1st.  However, the voltage reading for CPU 2 is
> .05v lower at 1.65v.  Any processor gurus here?
> 

That sounds a bit suspicious indeed, and could certainly cause that
kind of errors.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
