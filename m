Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289839AbSAPD0L>; Tue, 15 Jan 2002 22:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289880AbSAPD0C>; Tue, 15 Jan 2002 22:26:02 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:44260 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289839AbSAPDZx>;
	Tue, 15 Jan 2002 22:25:53 -0500
Date: Tue, 15 Jan 2002 22:25:47 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Daniel Phillips <phillips@bonn-fries.net>
cc: "H. Peter Anvin" <hpa@zytor.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: initramfs buffer spec -- second draft
In-Reply-To: <E16Qa0W-0001kH-00@starship.berlin>
Message-ID: <Pine.GSO.4.21.0201152220140.4339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Jan 2002, Daniel Phillips wrote:

> It's a mistake not to fix this tool.  I'll post the cost in terms of bytes
> wasted shortly, pretty tough to argue with that, right?

No, it's actually very easy: squeezing 40 bytes out of file is not worth
_any_ efforts.

