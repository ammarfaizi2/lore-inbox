Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261155AbUK0ICD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261155AbUK0ICD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Nov 2004 03:02:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbUK0ICD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Nov 2004 03:02:03 -0500
Received: from main.gmane.org ([80.91.229.2]:1997 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261155AbUK0IB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Nov 2004 03:01:59 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: Suspend 2 merge: 35/51: Code always built in to the kernel.
Date: Sat, 27 Nov 2004 01:00:59 -0800
Message-ID: <m2fz2vfyyc.fsf@tnuctip.rychter.com>
References: <1101292194.5805.180.camel@desktop.cunninghams>
	<1101298112.5805.330.camel@desktop.cunninghams>
	<20041125233243.GB2909@elf.ucw.cz>
	<1101427035.27250.161.camel@desktop.cunninghams>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 66-27-68-14.san.rr.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5 (chestnut, linux)
Cancel-Lock: sha1:C/Z5s8blf9L1xBOgC8SZ3KLrq54=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Nigel" == Nigel Cunningham <ncunningham@linuxmail.org>:
 Nigel> Hi.
 Nigel> On Fri, 2004-11-26 at 10:32, Pavel Machek wrote:
[...]
 >> Plus kernel now actually expects user interaction to solve problems
 >> during boot. No, no.

 Nigel> You want your cake and to eat it too? :> We don't want to warn
 Nigel> the user before they shoot themselves in the foot, but not
 Nigel> loudly enough that they can't help notice and choose to do
 Nigel> something before the damage is done?

You're forgetting that Pavel's idea of user interaction is via BUG_ON()
and panic(). That's obviously "cleaner", "less ugly", and "smaller".

Sorry, can't help being sarcastic after watching the tone of some of
these exchanges, particularly comments from pedestals that are being
made so often. I find it rather sad.

--J.

