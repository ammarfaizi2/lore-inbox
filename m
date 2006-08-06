Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750749AbWHFWl3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWHFWl3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 18:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWHFWl3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 18:41:29 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:63645 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750749AbWHFWl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 18:41:28 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=I3PC79V+kzqtXIqchjIRjSoJx6LJcj6ukZnbmInPO2DAEicyvmdtcZPGW4/2YtlB3QMpB5EP3jvZ1DUzNpRcUhbg2nq+FvZADeVsPPNEcukDVKKiVCfcPCgj5s9HDOnhd6sM1OTVCJ8kf/hHWmIO4iAqIWaW07gQxZpIyn31bCk=
Message-ID: <41840b750608061541r2a6eb9e1uab5474c3899e2283@mail.gmail.com>
Date: Mon, 7 Aug 2006 01:41:27 +0300
From: "Shem Multinymous" <multinymous@gmail.com>
To: "Arjan van de Ven" <arjan@infradead.org>
Subject: Re: [PATCH 01/12] thinkpad_ec: New driver for ThinkPad embedded controller access
Cc: "Andrew Morton" <akpm@osdl.org>, rlove@rlove.org, khali@linux-fr.org,
       gregkh@suse.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
       hdaps-devel@lists.sourceforge.net
In-Reply-To: <1154890406.3054.127.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <11548492171301-git-send-email-multinymous@gmail.com>
	 <11548492242899-git-send-email-multinymous@gmail.com>
	 <20060806005613.01c5a56a.akpm@osdl.org>
	 <41840b750608060256g1a7bb9c3s843d3ac08e512d63@mail.gmail.com>
	 <20060806030749.ab49c887.akpm@osdl.org>
	 <41840b750608060344p59293ce0xc75edfbd791b23c@mail.gmail.com>
	 <1154890406.3054.127.camel@laptopd505.fenrus.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arjan,

On 8/6/06, Arjan van de Ven <arjan@infradead.org> wrote:
> Open source is all about trust. Person A takes a patch from person B
> because person A has trust in B (conditional on the patch meeting a
> technical standard). In B's technical ability, in B's intentions, in B's
> sincerity, in B's honesty when he says "this is my work and you can use
> it because nobody but me has a claim on this".

Excellent points.


> Using a fake name is not a good way to gain such trust... At all.
> Explicitly refusing to say who you really are just lowers the trust even
> more, because it gives a strong appearance that something really fishy
> is going on.

Agreed. But this is only a heuristic; maybe in this case nothing fishy
is going on, whereas many nice-looking patches would reek to heaven if
inspected more closely.

So how about exercising judgment? Look up the tp_smapi development
history on sf.net (under project "tpctl"), the relevant posts on
thinkpad-devel, hdaps-devel and even a bit on lkml, and see if this
looks like standard, clean kernel development or a sinister attempt to
steal our precious bolidy fluids.

  Shem
