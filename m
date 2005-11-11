Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751201AbVKKVQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751201AbVKKVQa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Nov 2005 16:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751202AbVKKVQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Nov 2005 16:16:30 -0500
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:47307
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S1751201AbVKKVQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Nov 2005 16:16:30 -0500
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: Robert Love <rml@novell.com>, Andrew Morton <akpm@osdl.org>,
       jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: Kernel Panic 2.6.14-git (pictures)
Date: Fri, 11 Nov 2005 16:16:26 -0500
Message-Id: <20051111211358.M24121@linuxwireless.org>
X-Mailer: Open WebMail 2.40 20040816
X-OriginatingIP: 16.126.157.6 (abonilla@linuxwireless.org)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov wrote:
>Heh ;)
>
>Alejandro, didn't you have another issue with pcspeaker driver in
>conjunction with PNP? Did my patch moving inpu core into a separate
>directory and registering it early help?
>
> 
>
>>Linus, can you please merge Dmitry's patch? ;o
>>
>
>Thank you for testing it!

Dmitry,

It works perfectly now. Thanks for the patch and for merging.

.Alejandro

>


