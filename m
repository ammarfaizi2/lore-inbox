Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964972AbWEBVJd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964972AbWEBVJd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 May 2006 17:09:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWEBVJd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 May 2006 17:09:33 -0400
Received: from pproxy.gmail.com ([64.233.166.178]:9891 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S964972AbWEBVJc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 May 2006 17:09:32 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=ez0oI+PeIySjrXGJBXQsArxopdyGYNJJ6j7T9w2PAHWq6pVZ/7mnMbyBmB1J5GWffsrQDJX2XxHbc0uHyOLzhkAw/UjnJOeJlfoORHLnEn4MCOju1NQf6OHmkj/nmWiSogyUeS/8gKEKPTRQibPaoS3PmdMV4S9GgFIwGbMbg84=
Message-ID: <4457CA80.8010006@gmail.com>
Date: Wed, 03 May 2006 05:09:20 +0800
From: "Antonino A. Daplas" <adaplas@gmail.com>
User-Agent: Thunderbird 1.5.0.2 (X11/20060420)
MIME-Version: 1.0
To: Olivier Fourdan <fourdan@gmail.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: framebuffer broken in 2.6.16.x and 2.6.17-rc3 ?
References: <60f2b0dc0605021251i1c883617vf132e8bdeffd6c7f@mail.gmail.com>
In-Reply-To: <60f2b0dc0605021251i1c883617vf132e8bdeffd6c7f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olivier Fourdan wrote:
> hi all,
> 
> Sorry if this has been already covered recently, but it seems that the
> framebuffer doesn't work anymore in 2.6.16.9 and 2.6.17-rc3, while it
> worked in 2.6.16 at least.
> 
> I'm surprised noone has raised that issue yet, so I'm wondering if I'm
> missing something obvious :) When using the fb in 2.6.16.x and
> 2.6.17-rc3, the screen stays just black, nothing is displayed... I'm
> using the regular unaccelerated vesa framebuffer.
> 
> I'm wondering if this could related to the fb changes that occured
> after 2.6.16 initial release and if other people are experiencing
> issues with frame buffer recently.

There should be no issues, especially with the vesa framebuffer. Can you 
post your dmesg and config?

Tony
