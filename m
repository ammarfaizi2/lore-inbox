Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262888AbUKYBSI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262888AbUKYBSI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 20:18:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262896AbUKYBQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 20:16:56 -0500
Received: from main.gmane.org ([80.91.229.2]:20375 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262888AbUKYBNe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 20:13:34 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Date: Wed, 24 Nov 2004 17:22:27 -0800
Message-ID: <m2zn16204s.fsf@tnuctip.rychter.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	<1101296414.5805.286.camel@desktop.cunninghams>
	<20041124132949.GB13145@infradead.org>
	<m2d5y23o61.fsf@tnuctip.rychter.com>
	<20041124230232.GA22509@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5 (chestnut, linux)
Cancel-Lock: sha1:o5EbPJxKSqeS4WR34ZQFN7iZ+tw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:
 Christoph> On Wed, Nov 24, 2004 at 01:57:58PM -0800, Jan Rychter wrote:
 >> Obviously you have never actually tried to use software suspend in
 >> real life.
 >>
 >> I would kindly suggest that you try to use it on your laptop for at
 >> least several weeks in various circumstances. These features are a
 >> result of years of user experience.

 Christoph> I tend to buy laptops that just suspend when closing the
 Christoph> lid, and no, I never had the strange desired to immediately
 Christoph> reverse my choice.  Neither do I want to stop the shutdown
 Christoph> that I just initiated.

 Christoph> But for those people who do shutdown has a nice option to
 Christoph> delay the actual shutdown/reboot - I'm pretty sure the same
 Christoph> can be done for swsusp without sprinkling hooks all over the
 Christoph> kernel.

Please accept that there are people who requested these features and
there are people who find them useful.

I really hope you understand that delaying a suspend is very different
from allowing the user to interrupt it.

Also, many people suspend Linux only to reboot into Windows. In this
case, the ability to tell the machine to reboot instead of powering down
is very useful. Obviously, a perfect user would plan ahead and suspend
"appropriately", depending on what he wants to do
afterwards. Unfortunately, I have found that I'm not a perfect user and
that I really tend to use and like these features.

As for me, I would much rather have a useful kernel that a beautiful
kernel, because I rather tend to use it than watch it, but I can
understand that other people may have different priorities. I would
suggest we find a compromise.

--J.

