Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277435AbRKSKkZ>; Mon, 19 Nov 2001 05:40:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277514AbRKSKkQ>; Mon, 19 Nov 2001 05:40:16 -0500
Received: from tone.orchestra.cse.unsw.EDU.AU ([129.94.242.28]:29670 "HELO
	tone.orchestra.cse.unsw.EDU.AU") by vger.kernel.org with SMTP
	id <S277435AbRKSKkG>; Mon, 19 Nov 2001 05:40:06 -0500
From: Neil Brown <neilb@cse.unsw.edu.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 19 Nov 2001 21:40:14 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15352.57742.799052.405674@notabene.cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Devlinks.  Code.  (Dcache abuse?)
In-Reply-To: message from Alan Cox on Monday November 19
In-Reply-To: <15352.32969.717938.153375@notabene.cse.unsw.edu.au>
	<E165lUX-00066W-00@the-village.bc.nu>
X-Mailer: VM 6.72 under Emacs 20.7.2
X-face: [Gw_3E*Gng}4rRrKRYotwlE?.2|**#s9D<ml'fY1Vw+@XfR[fRCsUoP?K6bt3YD\ui5Fh?f
	LONpR';(ql)VM_TQ/<l_^D3~B:z$\YC7gUCuC=sYm/80G=$tt"98mr8(l))QzVKCk$6~gldn~*FK9x
	8`;pM{3S8679sP+MbP,72<3_PIH-$I&iaiIb|hV1d%cYg))BmI)AZ
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday November 19, alan@lxorguk.ukuu.org.uk wrote:
> > As I understand trademarks, they are granted for a particular context.
> > There is no conflict between "Dove" as a brand name for soap, "Dove"
> > as a brand name for chocolate, and "Dove" as used by bird watchers in
> > their taxonomy.
> 
> We have already had a vendor threaten legal action if we didn't change the
> name of a file system before merging it with the kernel.
> 
> Alan

I think you missed part of my point.
There are lots of different name spaces in the kernel.
Filesystem names.  Driver names.  Module names.

Some of them may well have trademark related issues.

But the namespace that is the current issue, the namespace of
currently available devices, is not a namespace where I would expect
trademarks to ever come up.  It is name space of interfaces and
instances.

So I hold that "trademark issues" is not a valid reason to avoid
moving from pure b/c+major+minor names to textual names as the
preferred names for currently available devices.

NeilBrown
