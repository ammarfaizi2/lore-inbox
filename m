Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263866AbTJ1Gty (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 01:49:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263869AbTJ1Gty
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 01:49:54 -0500
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:30729 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S263866AbTJ1Gtx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 01:49:53 -0500
Date: Tue, 28 Oct 2003 07:49:27 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Transmit timeout with 3c395, 2.4.19, 2.4.22
Message-ID: <20031028064927.GE7973@gamma.logic.tuwien.ac.at>
References: <20031027141358.GA26271@gamma.logic.tuwien.ac.at> <20031027111827.07b04891.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20031027111827.07b04891.akpm@osdl.org>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Okt 2003, Andrew Morton wrote:
> > creeping in. I would like to know wether this can be the case, or
> > wether there is something else (switches on the other side, ...) which
> > may have produced these errors.
> 
> Yes, a bad cable might explain this.  Or another host which is babbling
> away all the time (on a half-duplex setup).

The last will not be the case, all is full-duplex here. I will report
back after I some time of tests with a new nic. Maybe the one was
finally broken. Thanks for you answer!

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
it's at times like this, when
I'm trapped in a Vogon airlock with a man from Betelgeuse,
and about to die from asphyxiation in deep space that I
really wish I'd listened to what my mother told me when I
was young.'
`Why, what did she tell you?'
`I don't know, I didn't listen.'
                 --- Arthur coping with certain death as best as he could.
                 --- Douglas Adams, The Hitchhikers Guide to the Galaxy
