Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267231AbUGMX3O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267231AbUGMX3O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 19:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267232AbUGMX3O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 19:29:14 -0400
Received: from main.gmane.org ([80.91.224.249]:16363 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S267231AbUGMX3M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 19:29:12 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: [PATCH] swsusp bootsplash support
Date: Wed, 14 Jul 2004 04:27:16 -0700
Message-ID: <m2n022n817.fsf@tnuctip.rychter.com>
References: <20040708110549.GB9919@linux.nu> <20040708133934.GA10997@infradead.org>
 <20040708204840.GB607@openzaurus.ucw.cz>
 <20040708210403.GA18049@infradead.org> <20040708225216.GA27815@elf.ucw.cz>
 <20040708225501.GA20143@infradead.org> <20040709051528.GB23152@elf.ucw.cz>
 <20040709115531.GA28343@redhat.com>
 <20040710123422.GC607@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110002 (No Gnus v0.2) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:gUiRFsWR2IhcgrvV2bwFCK4Uo84=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Pavel" == Pavel Machek <pavel@suse.cz> writes:
 Pavel> Hi!
 > But I guess swsusp is going to make this more "interesting" as
 > progressbar is nice to have there, and userland can not help at that
 > point.
 >>
 >> Personally I'd prefer the effort went into making suspend actually
 >> work on more machines rather than painting eyecandy for the minority
 >> of machines it currently works on.

 Pavel> Actually, it does work on most of UP/IDE machines by now.
 Pavel> Remaining problems tend to be unsupported drivers. I can't help
 Pavel> with devices I do not have, unfortunately, so there's little I
 Pavel> can do.

[...]

Just to clarify -- in one of my previous posts I said that swsusp2 works
very well for me. I meant *swsusp2*, not swsusp. It is unfortunate that
the two projects are so similarly named. They are very different from
the user perspective.

--J.

