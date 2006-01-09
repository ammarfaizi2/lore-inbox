Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161255AbWAIAgP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161255AbWAIAgP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Jan 2006 19:36:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965365AbWAIAgO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Jan 2006 19:36:14 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:32725 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965364AbWAIAgN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Jan 2006 19:36:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=psAx0bOTcoPfh8jNm1nUGaJZeGa6963F3C/w8UXN2s0LC6EbLfZN+pl1+3ne+FmqI/NtturGRBfz4B51imkwX1h1Ju38XydCY6iBgI0CjwOpZgGXNUt4OF8DBj44i69bcGc/SmBc2ifgADJJEhf7kcTTMzyfi+ynEV4b6IIxMeU=
Message-ID: <43C1AFD4.9090007@gmail.com>
Date: Mon, 09 Jan 2006 08:35:32 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Lukas Hejtmanek <xhejtman@mail.muni.cz>, linux-kernel@vger.kernel.org
Subject: Re: intelfb
References: <20060108234839.GF3001@mail.muni.cz> <20060108235753.GR3774@stusta.de> <43C1ACB4.4030704@gmail.com> <20060109002912.GS3774@stusta.de>
In-Reply-To: <20060109002912.GS3774@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> On Mon, Jan 09, 2006 at 08:22:12AM +0800, Antonino A. Daplas wrote:
>> Adrian Bunk wrote:
>>> On Mon, Jan 09, 2006 at 12:48:40AM +0100, Lukas Hejtmanek wrote:
>>>
>>>> Hello,
>>> Hi Lukas,
>>>
>>>> is someone developing intelfb driver? Or is it some old (maybe functional) code?
>>> the MAINTAINERS file in the kernel sources says:
>>>
>>> INTEL 810/815 FRAMEBUFFER DRIVER
>>> P:      Antonino Daplas
>>> M:      adaplas@pol.net
>>> L:      linux-fbdev-devel@lists.sourceforge.net
>>> S:      Maintained
>>>
>> I maintain i810fb.  The author and maintainer of intelfb for 2.6 is Sylvain
>> Meyer. For 2.4, the author is David Dawes.
>> ...
> 
> Sorry, this happens when you only look at the MAINTAINERS file...
> 
> Can you add a MAINTAINERS entry for Sylvain?

Will do.

Tony
