Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262116AbVAYUvp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbVAYUvp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jan 2005 15:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262118AbVAYUvp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jan 2005 15:51:45 -0500
Received: from dsl093-002-214.det1.dsl.speakeasy.net ([66.93.2.214]:23229 "EHLO
	pickle.fieldses.org") by vger.kernel.org with ESMTP id S262116AbVAYUrJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jan 2005 15:47:09 -0500
Date: Tue, 25 Jan 2005 15:46:42 -0500
To: John Richard Moser <nigelenki@comcast.net>
Cc: dtor_core@ameritech.net, Linus Torvalds <torvalds@osdl.org>,
       Bill Davidsen <davidsen@tmr.com>, Valdis.Kletnieks@vt.edu,
       Arjan van de Ven <arjan@infradead.org>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>, Dave Jones <davej@redhat.com>,
       Andrew Morton <akpm@osdl.org>, marcelo.tosatti@cyclades.com,
       Greg KH <greg@kroah.com>, chrisw@osdl.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: thoughts on kernel security issues
Message-ID: <20050125204642.GC21764@fieldses.org>
References: <41F6604B.4090905@tmr.com> <Pine.LNX.4.58.0501250741210.2342@ppc970.osdl.org> <41F6816D.1020306@tmr.com> <41F68975.8010405@comcast.net> <Pine.LNX.4.58.0501251025510.2342@ppc970.osdl.org> <41F691D6.8040803@comcast.net> <d120d50005012510571d77338d@mail.gmail.com> <41F6A45D.1000804@comcast.net> <20050125202501.GA21764@fieldses.org> <41F6AC38.2060307@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F6AC38.2060307@comcast.net>
User-Agent: Mutt/1.5.6+20040907i
From: "J. Bruce Fields" <bfields@fieldses.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2005 at 03:29:44PM -0500, John Richard Moser wrote:
> This still doesn't give me any way to take a big patch and make little
> patches without hours of work and (N+2) kernel trees for N patches

Any path to getting a big complicated patch reviewed and into the kernel
is going to involve many hours of work, by more people than just the
submitter.

I highly recommend Andrew Morton's patch scripts, or something similar.

http://www.zip.com.au/~akpm/linux/patches/

--b.
