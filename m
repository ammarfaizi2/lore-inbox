Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932509AbWE3Vzz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932509AbWE3Vzz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:55:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932510AbWE3Vzz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:55:55 -0400
Received: from wx-out-0102.google.com ([66.249.82.197]:32778 "EHLO
	wx-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932509AbWE3Vzy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:55:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=BQjjcjL6aTjIhFJozNMs9NsMuC2L3/z9LQfBldiI/9wM/TMDDGyWJz0Y8J5HcUDgIYLzTuFnDj3O0o7X/spLDPSrGudWk885O0I//H/oZFhxvAQkgdQg9c+NbsDA1/LMswFVSpIDldbL924M0TevjZ/u/dq/a5tq/IROJXu6efM=
Message-ID: <447CBF53.8050703@gmail.com>
Date: Wed, 31 May 2006 05:55:31 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: "Antonino A. Daplas" <adaplas@gmail.com>
CC: David Lang <dlang@digitalinsight.com>, Jon Smirl <jonsmirl@gmail.com>,
       Dave Airlie <airlied@gmail.com>, "D. Hazelton" <dhazelton@enter.net>,
       Pavel Machek <pavel@ucw.cz>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Kyle Moffett <mrmacman_g4@mac.com>,
       Manu Abraham <abraham.manu@gmail.com>, linux cbon <linuxcbon@yahoo.fr>,
       Helge Hafting <helge.hafting@aitel.hist.no>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
Subject: Re: OpenGL-based framebuffer concepts
References: <20060519224056.37429.qmail@web26611.mail.ukl.yahoo.com>  <200605272245.22320.dhazelton@enter.net>  <9e4733910605272027o7b59ea5n5d402dabdd7167cb@mail.gmail.com>  <200605280112.01639.dhazelton@enter.net>  <21d7e9970605281613y3c44095bu116a84a66f5ba1d7@mail.gmail.com> <9e4733910605281759j2e7bebe1h6e3f2bf1bdc3fc50@mail.gmail.com> <Pine.LNX.4.63.0605301033330.4786@qynat.qvtvafvgr.pbz> <447CBEC5.1080602@gmail.com>
In-Reply-To: <447CBEC5.1080602@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Antonino A. Daplas wrote:
> David Lang wrote:
>> On Sun, 28 May 2006, Jon Smirl wrote:
>>

Correcting myself:
> 
> vesafb 640x480-8 (vga=0x305 video=vesafb:ypan,mtrr:3)

vga=0x301

> 
> real    0m0.572s
> user    0m0.001s
> sys     0m0.571s
> 
> vesafb 640x480-8 (vga=0x305 video=vesafb:ypan,mtrr:3,vremap:4)

vga=0x301

Tony
