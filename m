Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131500AbQKJU1f>; Fri, 10 Nov 2000 15:27:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131510AbQKJU1Z>; Fri, 10 Nov 2000 15:27:25 -0500
Received: from tantalum.btinternet.com ([194.73.73.80]:43410 "EHLO
	tantalum.btinternet.com") by vger.kernel.org with ESMTP
	id <S131500AbQKJU1R>; Fri, 10 Nov 2000 15:27:17 -0500
From: davej@suse.de
Date: Fri, 10 Nov 2000 20:26:35 +0000 (GMT)
To: "H. Peter Anvin" <hpa@transmeta.com>
cc: Brian Gerst <bgerst@didntduck.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Fwd: CPU detection revamp (Request for comments)]
In-Reply-To: <3A0C5297.D039881@transmeta.com>
Message-ID: <Pine.LNX.4.21.0011102025540.1089-100000@neo.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Nov 2000, H. Peter Anvin wrote:

> > And where does sysenter/sysexit fit in?
> sysenter/sysexit is the "sep" feature.

Ah, of course.
*slaps head*

regards,

davej.

-- 
| Dave Jones <davej@suse.de>  http://www.suse.de/~davej
| SuSE Labs

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
