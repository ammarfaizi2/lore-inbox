Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262536AbVCPG6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262536AbVCPG6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 01:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262537AbVCPG6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 01:58:55 -0500
Received: from smtp807.mail.sc5.yahoo.com ([66.163.168.186]:54135 "HELO
	smtp807.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262536AbVCPG6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 01:58:53 -0500
Message-ID: <4237D92A.3040109@sbcglobal.net>
Date: Wed, 16 Mar 2005 01:58:50 -0500
From: "Robert W. Fuller" <orangemagicbus@sbcglobal.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041223
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11 USB broken on VIA computer (not just ACPI)
References: <4237A5C1.5030709@sbcglobal.net>	<20050315203914.223771b2.akpm@osdl.org>	<4237C40C.6090903@sbcglobal.net>	<20050315213110.75ad9fd5.akpm@osdl.org>	<4237C61A.6040501@sbcglobal.net> <20050315215447.7975a0ff.akpm@osdl.org>
In-Reply-To: <20050315215447.7975a0ff.akpm@osdl.org>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Robert W. Fuller" <orangemagicbus@sbcglobal.net> wrote:
> Nobody's going to fix that machine while you persist in top-posting ;)

OK OK.  No more top posting.  It's Mozilla's fault you know....  It 
steers you in the wrong direction by leaving a few lines at the top. 
Yes I'm ashamed to admit I remember when the default behavior of mail 
clients was to put the cursor at the bottom.

> How old is it, anyway?

Hmm.  I think I built it in 2000.  Wow, time flies when you're having fun!

>>Of course, I don't know how well video capture is going to work without 
>>the apic programming.  So I guess I'm reduced to rebooting when I want 
>>to switch between USB peripherals and video capture?
 >
> hm, you didn't mention video capture before.  It should work OK?

I've only ever used it with the APIC enabled.  We'll see what happens 
without?

> Are you running the latest BIOS?

The manufacturer, Tyan, didn't produce more than a handful of BIOS'es 
within a matter of months after they started producing the board.  They 
haven't released an update since 2000.

> You may be able to set the thing up by hand with the help of
> Documentation/i386/IO-APIC.txt.

I'll check it out.  Thanks!
