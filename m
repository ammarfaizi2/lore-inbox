Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262929AbUKXW4n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262929AbUKXW4n (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 17:56:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262904AbUKXWyG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 17:54:06 -0500
Received: from zeus.kernel.org ([204.152.189.113]:10937 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262875AbUKXWqv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 17:46:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Suspend 2 merge: 24/51: Keyboard and serial console hooks.
Date: Wed, 24 Nov 2004 13:57:58 -0800
Message-ID: <m2d5y23o61.fsf@tnuctip.rychter.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	<1101296414.5805.286.camel@desktop.cunninghams>
	<20041124132949.GB13145@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5 (chestnut, linux)
Cancel-Lock: sha1:0Di4bbQg/fB091aFrWh5Z/HdVYI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:
 Christoph> On Wed, Nov 24, 2004 at 11:59:02PM +1100, Nigel Cunningham
 Christoph> wrote:
 >> Here we add simple hooks so that the user can interact with suspend
 >> while it is running. (Hmm. The serial console condition could be
 >> simplified :>). The hooks allow you to do such things as:
 >>
 >> - cancel suspending
 >> - change the amount of detail of debugging info shown
 >> - change what debugging info is shown
 >> - pause the process
 >> - single step
 >> - toggle rebooting instead of powering down

 Christoph> And why would we want this?  If the users calls the suspend
 Christoph> call he surely wants to suspend, right?

Obviously you have never actually tried to use software suspend in real
life.

I would kindly suggest that you try to use it on your laptop for at
least several weeks in various circumstances. These features are a
result of years of user experience.

--J.

