Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbTI3KGj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 06:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261316AbTI3KGj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 06:06:39 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:21723 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261314AbTI3KGh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 06:06:37 -0400
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] document optimizing macro for translating PROT_ to VM_
 bits
References: <20030929090629.GF29313@actcom.co.il>
	<20030929153437.GB21798@mail.jlokier.co.uk>
	<20030930071005.GY729@actcom.co.il>
	<buohe2u3f20.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030930074138.GG729@actcom.co.il>
	<buoad8m3dvn.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030930092403.GR29313@actcom.co.il>
	<buon0cm1tpm.fsf@mcspd15.ucom.lsi.nec.co.jp>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 30 Sep 2003 19:06:29 +0900
In-Reply-To: <buon0cm1tpm.fsf@mcspd15.ucom.lsi.nec.co.jp>
Message-ID: <buoekxy1tga.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Argh!

> Sure, it's not always worth the trouble/pain to do so unless you've
        ^ insert `but'

-Miles
-- 
"Though they may have different meanings, the cries of 'Yeeeee-haw!' and
 'Allahu akbar!' are, in spirit, not actually all that different."
