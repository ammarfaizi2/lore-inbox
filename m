Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280648AbRKNPZL>; Wed, 14 Nov 2001 10:25:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280647AbRKNPY5>; Wed, 14 Nov 2001 10:24:57 -0500
Received: from sm10.texas.rr.com ([24.93.35.222]:14530 "EHLO sm10.texas.rr.com")
	by vger.kernel.org with ESMTP id <S280634AbRKNPYG>;
	Wed, 14 Nov 2001 10:24:06 -0500
Content-Type: text/plain; charset=US-ASCII
From: Marvin Justice <mjustice@austin.rr.com>
Reply-To: mjustice@austin.rr.com
To: Chris Meadors <clubneon@hereintown.net>
Subject: Re:[OT] What Athlon chipset is most stable in Linux?
Date: Wed, 14 Nov 2001 09:28:35 -0600
X-Mailer: KMail [version 1.2]
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.40.0111140823040.88-100000@rc.priv.hereintown.net>
In-Reply-To: <Pine.LNX.4.40.0111140823040.88-100000@rc.priv.hereintown.net>
MIME-Version: 1.0
Message-Id: <01111409283504.00746@bozo>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 14 November 2001 07:27 am, Chris Meadors wrote:
> Anyway, to keep this kinda kernel related.  How well supported are the
> FireGL cards?  That is DRM wise, and of course X to go with that.
>
> -Chris

Drivers are distributed pretty much the same way as nVidia, ie., as a binary 
core along with the necessary wrappers to compile for new kernels, private 
libGL.so, etc.  Aside from that, we've generally had pretty positive 
experiences.

These aren't quake cards; in fact the demo1 fps are  surprisingly low. In 
serious OpenGL benchmarks, however,  
(http://www.specbench.org/gpc/opc.static/opcview.htm ) they're currently the 
fastest cards available for Linux by a long shot.

I think FGL is what people at ILM, Dreamworks, Digital Domain etc. are using 
at the moment in the gradual shift toward Linux on the artist's desktop. Not 
cheap --- unless you've already forked over $16K for Maya ;-)

-- 
Marvin Justice
Software Developer
BOXX Technologies, Inc.
www.boxxtech.com
512-235-6318 (V)
512-835-0434 (F)
