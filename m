Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263806AbUFQVhc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUFQVhc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 17:37:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUFQVhc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 17:37:32 -0400
Received: from vsmtp1b.tin.it ([212.216.176.141]:33217 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S263806AbUFQVhb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 17:37:31 -0400
Message-ID: <40D21104.5000802@stanchina.net>
Date: Thu, 17 Jun 2004 23:45:40 +0200
From: Flavio Stanchina <flavio@stanchina.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040401 Debian/1.6-4
X-Accept-Language: en
MIME-Version: 1.0
To: mdpoole@troilus.org
CC: linux-kernel@vger.kernel.org
Subject: Re: more files with licenses that aren't GPL-compatible
References: <200406180629.i5I6Ttn04674@freya.yggdrasil.com>	<87n032xk82.fsf@sanosuke.troilus.org> <20040617100930.A9108@adam>	<96BD7BAE-C092-11D8-8574-000393ACC76E@mac.com>	<40D20449.5000107@stanchina.net> <877ju5yjxp.fsf@sanosuke.troilus.org>
In-Reply-To: <877ju5yjxp.fsf@sanosuke.troilus.org>
X-Enigmail-Version: 0.83.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mdpoole@troilus.org wrote:
> Sure there is: To the extent that there is a real license problem,
> work with the copyright owner(s) for the files and binary blobs to
> resolve the problem.  [...]

Yes, of course that would be fine. I started with the implicit 
assumption that the license could not change, sorry.

This might open another can of worms however. Once you get a binary blob 
into the kernel and you know that it really is code for an embedded 
microprocessor or such, what is the "preferred form of the work for
making modifications to it"? Wouldn't that be source code in whatever 
language that blob is written in? Wouldn't that also require a toolchain 
to build it? MY opinion is that it' much better to get it out of the 
kernel anyway.

> Contrary to your (and SCO's) allegations, kernel gatekeepers
> generally exercise care with respect to new contributions.

I did not allege anything like that. I never doubted that Linus and most 
other maintainers do, in fact, understand legal things quite well, 
contrary to what SCO said or implied several times.

-- 
Ciao, Flavio

