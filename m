Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264345AbRGRXej>; Wed, 18 Jul 2001 19:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264375AbRGRXe3>; Wed, 18 Jul 2001 19:34:29 -0400
Received: from sgi.SGI.COM ([192.48.153.1]:58981 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S264345AbRGRXeV>;
	Wed, 18 Jul 2001 19:34:21 -0400
Subject: Re: noapic strikes back
From: Florin Andrei <florin@sgi.com>
To: Doug Ledford <dledford@redhat.com>
Cc: seawolf-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <3B55E7A8.1786F70A@redhat.com>
In-Reply-To: <995484908.1279.0.camel@stantz.corp.sgi.com> 
	<3B55E7A8.1786F70A@redhat.com>
Content-Type: text/plain
X-Mailer: Evolution/0.10 (Preview Release)
Date: 18 Jul 2001 16:34:02 -0700
Message-Id: <995499242.1838.2.camel@stantz.corp.sgi.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 Jul 2001 15:46:48 -0400, Doug Ledford wrote:
> Florin Andrei wrote:
> > 
> > I tried to boot the installer with and without "noapic" option.
> 
> When using my boot disk, you have to use the "apic" option, not the "noapic"
> option.

Oh, crap... :-(
Yes, "apic" is the right one. It works fine. Thank you.
Now if i only could do the same thing to the SGI XFS 1.0.1 installer...

P.S.: Doug, please, can you put a small README in the updates directory,
so people can know what option to use? I saw that URL floating around
for a while, so maybe some people (like me) will be confused when trying
to use your updated images. Thanks.

-- 
Florin Andrei

