Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263077AbTCWOVa>; Sun, 23 Mar 2003 09:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263078AbTCWOV2>; Sun, 23 Mar 2003 09:21:28 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:45474
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263077AbTCWOVS>; Sun, 23 Mar 2003 09:21:18 -0500
Subject: Re: PATCH: redo the n_tty fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0303221909590.768-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0303221909590.768-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048434292.10729.25.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 23 Mar 2003 15:44:52 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2003-03-23 at 03:11, Linus Torvalds wrote:
> On Sat, 22 Mar 2003, Alan Cox wrote:
> > 
> > I think this way of doing it is right but it could do with further
> > review
> 
> Alan, please stop doing whitespace changes that are WRONG.

If you stopped merging broken patches I wouldn't have to redo them ;)

I missed that one when fixing the other stuff up to Torvalds style.


