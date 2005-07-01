Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263264AbVGAH2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263264AbVGAH2m (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 03:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263266AbVGAH2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 03:28:42 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:16883 "EHLO
	tyo202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S263264AbVGAH2h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 03:28:37 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <miklos@szeredi.hu>, aia21@cam.ac.uk, arjan@infradead.org,
       linux-kernel@vger.kernel.org, frankvm@frankvm.com
Subject: Re: FUSE merging?
References: <E1DnvCq-0000Q4-00@dorka.pomaz.szeredi.hu>
	<20050630022752.079155ef.akpm@osdl.org>
	<E1Dnvhv-0000SK-00@dorka.pomaz.szeredi.hu>
	<1120125606.3181.32.camel@laptopd505.fenrus.org>
	<E1Dnw2J-0000UM-00@dorka.pomaz.szeredi.hu>
	<1120126804.3181.34.camel@laptopd505.fenrus.org>
	<1120129996.5434.1.camel@imp.csi.cam.ac.uk>
	<20050630124622.7c041c0b.akpm@osdl.org>
	<E1DoF86-0002Kk-00@dorka.pomaz.szeredi.hu>
	<20050630235059.0b7be3de.akpm@osdl.org>
	<E1DoFcK-0002Ox-00@dorka.pomaz.szeredi.hu>
	<20050701001439.63987939.akpm@osdl.org>
From: Miles Bader <miles@lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
Date: Fri, 01 Jul 2005 16:27:49 +0900
In-Reply-To: <20050701001439.63987939.akpm@osdl.org> (Andrew Morton's message of "Fri, 1 Jul 2005 00:14:39 -0700")
Message-Id: <buoll4rj896.fsf@mctpc71.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:
>>   - efficient protocol, optimized for less context switches
>
> One wouldn't really expect a userspace filesystem to be particularly fast,
> and the performance will be dominated by memory copies and IO wait anyway.

Well there's slow and then there's slow...  numbers are always nice though.

-miles
-- 
[|nurgle|]  ddt- demonic? so quake will have an evil kinda setting? one that
            will  make every christian in the world foamm at the mouth?
[iddt]      nurg, that's the goal
