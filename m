Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751016AbWAJIwX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751016AbWAJIwX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 03:52:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751017AbWAJIwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 03:52:23 -0500
Received: from zproxy.gmail.com ([64.233.162.203]:30350 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751013AbWAJIwW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 03:52:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=lEPiO69CyaHODMPh+wsGWmkLYB0g9vr1NWKPV6vxEaezFEFjlEG4Tubwr8DAM2rRGaS7QDhgihSEN+lM68B2FDWdmnN+KHe+tH6A31sjhGuKc1cHdVFLlRayNTQVKUzRuV3AtAAE9Fw+5B4TWg032zx3gT8pDIKgmp3c19QJc6w=
Message-ID: <43C3759A.4030106@gmail.com>
Date: Tue, 10 Jan 2006 16:51:38 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org
Subject: Re: intelfb
References: <20060108234839.GF3001@mail.muni.cz> <20060108235753.GR3774@stusta.de> <43C1ACB4.4030704@gmail.com> <20060109002912.GS3774@stusta.de> <20060109101805.GK3001@mail.muni.cz> <43C30DEA.1050101@gmail.com> <20060110083533.GF12559@mail.muni.cz>
In-Reply-To: <20060110083533.GF12559@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:
> On Tue, Jan 10, 2006 at 09:29:14AM +0800, Antonino A. Daplas wrote:
>> Yeah, he said he's going to be busy and he was not responding to e-mails
>> for some time now. Anyway, what's your concern?
> 
> I want to know, whether there is someone with i915 graphic card that is working
> with intelfb. Some my tests and hacking points to fakct that routine to

You can always check the intelfb changelog...

http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=history;h=4bba3925924148c24fb0c7636a04ad69a6a56b84;f=drivers/video/intelfb/intelfbdrv.c

> calculate pixel mod clock is wrong for this chip. And also I have an idea how to
> setup a graphic mode on local LCD (laptops).
> 

Can you post your hack to this list?

Tony
