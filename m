Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289998AbSAOQIc>; Tue, 15 Jan 2002 11:08:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290004AbSAOQIW>; Tue, 15 Jan 2002 11:08:22 -0500
Received: from leibniz.math.psu.edu ([146.186.130.2]:62921 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S289998AbSAOQIN>;
	Tue, 15 Jan 2002 11:08:13 -0500
Date: Tue, 15 Jan 2002 11:08:11 -0500 (EST)
From: Alexander Viro <viro@math.psu.edu>
To: Paul Larson <plars@austin.ibm.com>
cc: Davide Libenzi <davidel@xmailserver.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux-2.5.2
In-Reply-To: <Pine.LNX.4.33.0201150943210.3557-100000@eclipse.ltc.austin.ibm.com>
Message-ID: <Pine.GSO.4.21.0201151107480.4339-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 15 Jan 2002, Paul Larson wrote:

> On Mon, 14 Jan 2002, Davide Libenzi wrote:
> > Linus, i've a weird behavior with 2.5.2
> > swapon first fails at boot ( early stage ) then it succeed ( late boot
> > stage ) but the swap is not actually activated. Running swapon by hand it
> > reports a seccessful operation but the swap is not on.
> > I'm trying to understand what is happening ...
> 
> I am having this problem also

ftp.math.psu.edu/pub/viro/LB38-fix-C2

