Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751402AbVLESAl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbVLESAl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 13:00:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751399AbVLESAl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 13:00:41 -0500
Received: from styx.suse.cz ([82.119.242.94]:35260 "EHLO mail.suse.cz")
	by vger.kernel.org with ESMTP id S1751397AbVLESAk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 13:00:40 -0500
Date: Mon, 5 Dec 2005 19:00:38 +0100
From: Jiri Benc <jbenc@suse.cz>
To: mbuesch@freenet.de
Cc: linux-kernel@vger.kernel.org, bcm43xx-dev@lists.berlios.de,
       NetDev <netdev@vger.kernel.org>
Subject: Re: Broadcom 43xx first results
Message-ID: <20051205190038.04b7b7c1@griffin.suse.cz>
In-Reply-To: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
References: <E1Eiyw4-0003Ab-FW@www1.emo.freenet-rz.de>
X-Mailer: Sylpheed-Claws 1.0.4a (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 04 Dec 2005 19:50:08 +0100, mbuesch@freenet.de wrote:
> The team is in the progress of writing a SoftwareMAC layer,
> which is needed for the bcm device. The SoftMAC is still very
> incomplete. So do not expect to do any fancy stuff like WPA
> or something line that with it.

Why yet another attempt to write 802.11 stack? Sure, the one currently
in the kernel is unusable and everybody knows about it. But why not to
improve code opensourced by Devicescape some time ago instead of
inventing the wheel again and again? Yes, I know that code is not
perfect and needs a lot of work, but it is the best piece of code we
have available now. And it _does_ support WPA and such - in fact, it is
nearly complete.

Please take a look at http://kernel.org/pub/linux/kernel/people/jbenc/

Thanks,

-- 
Jiri Benc
SUSE Labs
