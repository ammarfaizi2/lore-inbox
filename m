Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263807AbTDXUEo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 16:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263825AbTDXUEo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 16:04:44 -0400
Received: from marshall.modwest.com ([216.129.251.30]:28296 "EHLO
	mail.modwest.com") by vger.kernel.org with ESMTP id S263807AbTDXUEm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 16:04:42 -0400
From: Nils Holland <nils@ravishing.de>
Organization: Ravishing Enterprises
To: Linus Torvalds <torvalds@transmeta.com>
Subject: Re: Flame Linus to a crisp!
Date: Thu, 24 Apr 2003 22:16:32 +0200
User-Agent: KMail/1.5.1
References: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
In-Reply-To: <Pine.LNX.4.44.0304232012400.19176-100000@home.transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304242216.32576.nils@ravishing.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 24 April 2003 05:59, Linus Torvalds wrote:

> In short, it's perfectly ok to sign a kernel image - I do it myself
> indirectly every day through the kernel.org, as kernel.org will sign the
> tar-balls I upload to make sure people can at least verify that they came
> that way. Doing the same thing on the binary is no different: signing a
> binary is a perfectly fine way to show the world that you're the one
> behind it, and that _you_ trust it.

Do I understand that? Well, what you are doing is signing the kernel tar-ball, 
so that when I download it from my favorite mirror, I can check if I really 
received the kernel yoz released yesterday, or if someone probably put some 
funny backdoors in there and now hopes me to become his prey. This has little 
to do with DRM, which stands for Digital Rights Management. Your signing 
doesn't have much to do with rights - I can still use a backdoored kernel if 
I want to. Signing source / binary files for such purposes is clearly ok.

DRM, however, obviously comes in when it comes to managing / securing rights. 
This would mean that under certain conditions, I might not be able to use 
something the way I would like to. As a short example, my digital satellite 
card may refuse to work with a stock kernel because someone thinks I might 
illegally decrypt pay-tv channels. So I might be forced to use a kernel 
signed by <some_vendor>, because that kernel is known to have hooks in it 
that make sure that I can't do such decrypting of pay-tv.

However, what would happen if I want to upgrade to the latest kernel Linus has 
just released? If I compile it myself, my tv card would not work with it. So 
I'd have to wait for whoever signed it to release their signed version. And 
they might even stop signing new kernels at some point in time, or probably 
ask me to pay money to get their specifically signed kernel. And in the end, 
all this nonsense could be there even though I never even intended to do what 
<whoever> wants to prevent me from doing.

To come back from this example to reality, signing things is not neccessarily 
bad. Technology that acts on such signatures is not inherently bad either - 
it's like the kitchen knife that you can use to cut food you want to eat, 
while it can also be used as a lethal weapon. So it always depends on how 
things get used, not on whether they exist or not. Surely, we could ban all 
knives, but the question is if the number of deaths we'd prevent by doing so 
would make up for the difficulites we'd get in the field of food preparation. 
For DRM, about the same question applies. And if the OSS community doesn't 
automatically heasitate to pick this technology up, it's possible that the 
positive effects can be made dominant - if we let all this stuff happen in 
the hands of "the others", it's likely that they would focus on using it only 
for "bad" things. It'd be like a kitchen knive put into the hands of a 
psychopath instead of the hands of a well-meaning housewife.

Bye,
Nils <nils@ravishing.de>

-- 
celine.ravishing.de
Linux 2.4.21-rc1 #5 Tue Apr 22 13:12:21 CEST 2003 i686
  9:59pm  up  4:21,  3 users,  load average: 0.13, 0.04, 0.01

