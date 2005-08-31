Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964835AbVHaPRr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964835AbVHaPRr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Aug 2005 11:17:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964837AbVHaPRr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Aug 2005 11:17:47 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:40834 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964835AbVHaPRq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Aug 2005 11:17:46 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=qoYFXbG41P1fP7NIEOA829BEOTViOSlc6RZtgEc7Q7G+03bCtHG0WK6GOUULZyF5mrFaYFflLsvWXTkA/hlyxwz5jHdxcdrNc/NYyJyLvKD7gsh/96VU9W6LG9ucCJPicJL2exGBxYSKb3i7CDV081MnqXeR4Wpw1vyunhHdp/k=
Message-ID: <4315CA02.4000802@gmail.com>
Date: Wed, 31 Aug 2005 23:17:22 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050715)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nilesh Agrawal <nilesh.agrawal@gmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: tty problem
References: <9a9e5ab90508310806114ab96b@mail.gmail.com>
In-Reply-To: <9a9e5ab90508310806114ab96b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nilesh Agrawal wrote:
> Hi all,
> 
> I have a peculiar problem with the kernel messages being printed during startup.
> During startup the messages are printed only uptill the monitor
> (screen) gets filled, the screen doesnt scroll down and no further
> messages are printed. However the computer boots normally, and I get my
> graphical desktop when X starts.
> Moreover  moving to tty1 (CTRL-ALT-F1)  doesnt give me anything, but
> mingetty program is running on tty1.
> Booting in single user mode, the same problem persists. I cant see
> anything after the screen gets filled.
> Does anyone  know where is the problem??
> Thanks in advance.

Please send more info --- output of dmesg, kernel config, hardware desription.

Tony
