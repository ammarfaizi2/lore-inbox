Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293739AbSB1Xip>; Thu, 28 Feb 2002 18:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292945AbSB1Xgq>; Thu, 28 Feb 2002 18:36:46 -0500
Received: from mx1out.umbc.edu ([130.85.253.51]:63188 "EHLO mx1out.umbc.edu")
	by vger.kernel.org with ESMTP id <S310202AbSB1Xfk>;
	Thu, 28 Feb 2002 18:35:40 -0500
Date: Thu, 28 Feb 2002 18:35:36 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Peter Hutnick <peter@fpcc.net>
cc: Jason Cook <jasonc@reinit.org>, <linux-kernel@vger.kernel.org>
Subject: Re: wvlan_cs in limbo?
In-Reply-To: <200202282303.QAA15397@perth.fpcc.net>
Message-ID: <Pine.SGI.4.31L.02.0202281834390.5604431-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Feb 2002, Peter Hutnick wrote:

> The wvlan_cs driver is in the current pcmcia-cs package, but isn't built with
> "make all."  I'm "just an end user" so I am not really cut out for figuring
> out how to build it manually.

pcmcia-cs does not build modules if, by fading memory, the kernel has
pcmcia and cardbus support enabled.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

