Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262610AbTLJAPa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 19:15:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262707AbTLJAPa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 19:15:30 -0500
Received: from hibernia.jakma.org ([213.79.33.168]:37005 "EHLO
	hibernia.jakma.org") by vger.kernel.org with ESMTP id S262610AbTLJAP2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 19:15:28 -0500
Date: Wed, 10 Dec 2003 00:15:17 +0000 (GMT)
From: Paul Jakma <paul@clubi.ie>
X-X-Sender: paul@fogarty.jakma.org
To: William Lee Irwin III <wli@holomorphy.com>
cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Joe Thornber <thornber@sistina.com>, linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
In-Reply-To: <20031209235823.GT8039@holomorphy.com>
Message-ID: <Pine.LNX.4.56.0312100005270.30298@fogarty.jakma.org>
References: <Pine.LNX.4.44.0312092047450.1289-100000@logos.cnet>
 <Pine.LNX.4.56.0312092329280.30298@fogarty.jakma.org> <20031209235823.GT8039@holomorphy.com>
X-NSA: iraq saddam hammas hisballah rabin ayatollah korea vietnam revolt mustard gas
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Dec 2003, William Lee Irwin III wrote:

> Just apply the patch if you're for some reason terrified of 2.6.

Or get RedHat or Fedora to apply the patch.

Its a slightly safer bet though to have it in stock 2.4, guarantees
it will be there if one needs it 2 years down the road when upgrading
some box. (and non-LVM users wont be compiling it in).

So personally I'd rather Marcelo included it, being paranoid about
having support for access to data.

> -- wli

regards,
-- 
Paul Jakma	paul@clubi.ie	paul@jakma.org	Key ID: 64A2FF6A
	warning: do not ever send email to spam@dishone.st
Fortune:
"If you want to travel around the world and be invited to speak at a lot
of different places, just write a Unix operating system."
(By Linus Torvalds)
