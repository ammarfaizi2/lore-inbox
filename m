Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750946AbWERL25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbWERL25 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 07:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWERL25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 07:28:57 -0400
Received: from embla.aitel.hist.no ([158.38.50.22]:13276 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S1750741AbWERL24
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 07:28:56 -0400
Message-ID: <446C59B8.1060402@aitel.hist.no>
Date: Thu, 18 May 2006 13:25:44 +0200
From: Helge Hafting <helge.hafting@aitel.hist.no>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chase Venters <chase.venters@clientec.com>
CC: =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mru@inprovide.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Wiretapping Linux?
References: <4469D296.8060908@perkel.com> <Pine.LNX.4.61.0605161100590.27707@chaos.analogic.com> <Pine.LNX.4.64.0605161052120.32181@turbotaz.ourhouse> <yw1xodxx1znc.fsf@agrajag.inprovide.com> <Pine.LNX.4.64.0605161541390.32181@turbotaz.ourhouse>
In-Reply-To: <Pine.LNX.4.64.0605161541390.32181@turbotaz.ourhouse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chase Venters wrote:

>
> Yeah, so to wrap this malware conversation up -- the most effective 
> way to implant malicious code in Linux is to crack into developer 
> machines and sneak the changes in.
>
> And hope that someone doesn't notice.

The maintainer will.  Over and over, we see maintainers tell developers
to fix their patch - often the problem is something as small as
"bad withespace" or "stupid name for a variable".

Now try to get a backdoor in, and see the maintainer get a fit over
the changes that are clearly unrelated to the problem mentioned
in the changelog.

And if you succeed with the spyware anyway, then someone will notice
the strange packets going out.  That you cannot prevent, and it will then
be tracked down.  Or you get a backdoor in?  It will be found as soon as
it sees some use, or likely earlier with all the more or less automated
vulnerability chacking going on.

Helge Haftinjg

