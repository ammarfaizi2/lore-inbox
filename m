Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932360AbWGRTCX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932360AbWGRTCX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 15:02:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932362AbWGRTCX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 15:02:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:55609 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932360AbWGRTCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 15:02:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=bdSt+/ZQlkpsv+ssdzbeEiwMhV54fcDkEHKzUOn1WhtgoTKnQN0BNbi5pNHApjXN8d/N1iez7/C4iHYKrMWBybt3ZlmMf95LISBIL3fAALW97hzZU6BkBlIok7azsXAwWgQwzxW1sVakVNCXyFcAo5fpqWmA/fBajbQFLn0b1yk=
Message-ID: <3f396c130607181202l7bb93c27g4c7461182503eb42@mail.gmail.com>
Date: Tue, 18 Jul 2006 21:02:20 +0200
From: "febo@delenda.net" <febo@delenda.net>
To: "Dave Jones" <davej@redhat.com>, febo@delenda.net,
       linux-kernel@vger.kernel.org
Subject: Re: 'vintage' via dma bug
In-Reply-To: <20060718184052.GA9679@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <001001c6aa99$0476a380$fc01a8c0@EFFEPUNTO>
	 <20060718184052.GA9679@redhat.com>
X-Google-Sender-Auth: bee2d1400699c9b4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/06, Dave Jones <davej@redhat.com> wrote:
>
>
> I'm puzzled why you upgraded from one end-of-life'd distro to
> another ancient end-of-life'd distro.   You're more likely to get
> interest from the upstream developers if you're running
> something recent.  Even _I_ don't remember what was good/bad
> in the Fedora kernels from that era, and I built them :-)

 Quite simply, the damn thing is 350 km away from where I am, and I
can't just shut it down completely to reinstall or better yet swap it
with some decent and newer hardware. So I found that FC1 could be
upgraded with a 2.6 fedora RPM and found the 'nearest' at fedora
legacy and upgrade the kernel in 5 minutes.
Essentialy I'd like to find some confirmation/pointer regarding 1) if
the bug really affects my chipset 2) if 2.6.10 still has the fix, it
should have it of course, but...
