Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265298AbUBPCHj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Feb 2004 21:07:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265311AbUBPCHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Feb 2004 21:07:39 -0500
Received: from [80.72.36.106] ([80.72.36.106]:51654 "EHLO alpha.polcom.net")
	by vger.kernel.org with ESMTP id S265298AbUBPCHh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Feb 2004 21:07:37 -0500
Date: Mon, 16 Feb 2004 03:07:32 +0100 (CET)
From: Grzegorz Kulewski <kangur@polcom.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Christophe Saout <christophe@saout.de>, hch@infradead.org,
       thornber@redhat.com, mikenc@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: dm-crypt using kthread (was: Oopsing cryptoapi (or loop device?)
 on 2.6.*)
In-Reply-To: <20040215175337.5d7a06c9.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0402160303560.26082@alpha.polcom.net>
References: <402A4B52.1080800@centrum.cz> <1076866470.20140.13.camel@leto.cs.pocnet.net>
 <20040215180226.A8426@infradead.org> <1076870572.20140.16.camel@leto.cs.pocnet.net>
 <20040215185331.A8719@infradead.org> <1076873760.21477.8.camel@leto.cs.pocnet.net>
 <20040215194633.A8948@infradead.org> <20040216014433.GA5430@leto.cs.pocnet.net>
 <20040215175337.5d7a06c9.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 15 Feb 2004, Andrew Morton wrote:

> Is there more documentation that this?  I'd imagine a lot of crypto-loop
> users wouldn't have a clue how to get started on dm-crypt, especially if
> they have not used device mapper before.
> 
> And how do they migrate existing encrypted filesytems?

And is the format considered "stable"?
(= if I will create fs on it, will I have problems with future kernels?)


Grzegorz Kulewski

