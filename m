Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281972AbRKZR7v>; Mon, 26 Nov 2001 12:59:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281969AbRKZR7n>; Mon, 26 Nov 2001 12:59:43 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:45287 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S281972AbRKZR7Z>;
	Mon, 26 Nov 2001 12:59:25 -0500
Date: Mon, 26 Nov 2001 12:59:23 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Dana Lacoste <dana.lacoste@peregrine.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: RE: Release Policy [was: Linux 2.4.16  ]
In-Reply-To: <B51F07F0080AD511AC4A0002A52CAB445B2946@OTTONEXC1>
Message-ID: <Pine.SGI.4.31L.02.0111261258050.12817978-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2001, Dana Lacoste wrote:

> I think the problem is that there can't be any code
> changes from the last -[pre[-final]|rc] release and
> the actual release.
>
> And Marcelo seems to think this way too.

I think a better idea would be a feature freeze of some sort, where only
fixes to bugs discovered in -rcN series kernels can be added to -rcN+1

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

