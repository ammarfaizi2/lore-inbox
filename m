Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131728AbRCTGzq>; Tue, 20 Mar 2001 01:55:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131730AbRCTGzg>; Tue, 20 Mar 2001 01:55:36 -0500
Received: from mx3out.umbc.edu ([130.85.253.53]:29662 "EHLO mx3out.umbc.edu")
	by vger.kernel.org with ESMTP id <S131728AbRCTGzY>;
	Tue, 20 Mar 2001 01:55:24 -0500
Date: Tue, 20 Mar 2001 01:54:41 -0500
From: John Jasen <jjasen1@umbc.edu>
X-X-Sender: <jjasen1@irix2.gl.umbc.edu>
To: Eugene Crosser <crosser@average.org>
cc: <linux-kernel@vger.kernel.org>,
        "Brent D. Norris" <brent@biglinux.tccw.wku.edu>
Subject: Re: Mounting ISO via Loop Devices
In-Reply-To: <996tni$eo8$1@pccross.average.org>
Message-ID: <Pine.SGI.4.31L.02.0103200154050.587247-100000@irix2.gl.umbc.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Mar 2001, Eugene Crosser wrote:

> I can confirm that mount over loopback hangs on 2.4.2 (from kernel.org),
> regardless of the filesystem type.

It seems to have gone away in the 2.4.2-acX series.

--
-- John E. Jasen (jjasen1@umbc.edu)
-- In theory, theory and practise are the same. In practise, they aren't.

