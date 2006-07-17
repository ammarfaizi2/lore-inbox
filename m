Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbWGQSPz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbWGQSPz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:15:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751125AbWGQSPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:15:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.172]:29061 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751124AbWGQSPy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:15:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=juWWW4KV93VkRSTMgCQEVkAQozHNPp5cHz5/wSO6FzJZmBETWrEvt2hmH3/yzkbCLzJ0vF4FrY5IzwPvP3899YzOrZCciRw1l10C03Zs0oXffBc6IfTWfcxNr+pYfl503w4YakRO53mQGZzNJ7kvB/EcRTY9m+6hn/0eZTpuw9k=
Message-ID: <f96157c40607171115r4acccb00r3f6d93e3477a3a13@mail.gmail.com>
Date: Mon, 17 Jul 2006 20:15:53 +0200
From: "gmu 2k6" <gmu2006@gmail.com>
To: "Roman Zippel" <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org
Subject: Re: Re: i686 hang on boot in userspace
In-Reply-To: <Pine.LNX.4.64.0607171902310.6762@scrub.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060714150418.120680@gmx.net>
	 <Pine.LNX.4.64.0607171242440.6761@scrub.home>
	 <20060717133809.150390@gmx.net>
	 <Pine.LNX.4.64.0607171605500.6761@scrub.home>
	 <f96157c40607170759p1ab37abdi88d178c3503fb2e1@mail.gmail.com>
	 <Pine.LNX.4.64.0607171718140.6762@scrub.home>
	 <f96157c40607170858o567abe24r5d9bdd4895a906c9@mail.gmail.com>
	 <f96157c40607170902l47849e42qc4f1c64087a236d8@mail.gmail.com>
	 <Pine.LNX.4.64.0607171902310.6762@scrub.home>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/17/06, Roman Zippel <zippel@linux-m68k.org> wrote:
> Hi,
>
> On Mon, 17 Jul 2006, gmu 2k6 wrote:
>
> > either I'm too dumb or there is an undocumented way to enable SysRq on
> > bootup or the machine is really hanging hard. I'm not able use
> > Alt+Print as nothing happens besides console showing the typed in
> > characters ^[t.
>
> It might be a keyboard problem, try releasing Print, but keeping Alt
> pressed and then try another key.

maybe the problem is HP's Integrated Lights Out Java Applet. I will
try tomorrow morning in the server room.
