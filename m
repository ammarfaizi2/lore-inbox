Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751701AbVJTCji@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751701AbVJTCji (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 22:39:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbVJTCji
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 22:39:38 -0400
Received: from hibernia.jakma.org ([212.17.55.49]:29087 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S1751699AbVJTCjh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 22:39:37 -0400
Date: Thu, 20 Oct 2005 03:42:05 +0100 (IST)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@sheen.jakma.org
To: Krzysztof Halasa <khc@pm.waw.pl>
cc: Horms <horms@verge.net.au>, linux-kernel@vger.kernel.org,
       Rudolf Polzer <debian-ne@durchnull.de>, 334113@bugs.debian.org,
       Alastair McKinstry <mckinstry@debian.org>, security@kernel.org,
       team@security.debian.org, secure-testing-team@lists.alioth.debian.org
Subject: Re: kernel allows loadkeys to be used by any user, allowing for
 local root compromise
In-Reply-To: <m37jcakhsm.fsf@defiant.localdomain>
Message-ID: <Pine.LNX.4.63.0510200340280.3396@sheen.jakma.org>
References: <E1EQofT-0001WP-00@master.debian.org> <20051018044146.GF23462@verge.net.au>
 <m37jcakhsm.fsf@defiant.localdomain>
Mail-Copies-To: paul@hibernia.jakma.org
Mail-Followup-To: paul@hibernia.jakma.org
X-NSA: al aqsar jihad musharef jet-A1 avgas ammonium qran inshallah allah al-akbar martyr iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas british airways washington peroxide cool
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Oct 2005, Krzysztof Halasa wrote:

> OTOH I don't know why ordinary users should be allowed to change key
> bindings.

I like to load a custom keymap to swap ctrl and caps-lock.

I'd like to keep that ability, but I'd much prefer if it didn't 
affect all VTs, and if it didn't persist past the end of my session.

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
Fortune:
Don't worry if you're a kleptomaniac; you can always take something for it.
