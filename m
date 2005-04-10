Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261649AbVDJXbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261649AbVDJXbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Apr 2005 19:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261655AbVDJXap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Apr 2005 19:30:45 -0400
Received: from wproxy.gmail.com ([64.233.184.192]:38041 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261649AbVDJX1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Apr 2005 19:27:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=UoB6+ev8Qjjq66MDEYiiHHHlbkoJ1gzcwQW7KyDsPfoQidiOOR5JipYf3t/mvttfAvNJVeDcC7smJ8QpjfDwmgKAVHZnQop01m22G99Wwde1rcdwQe74civj1Tq++xQrOyQHqYKm5fTUOeOdT1RiGt7Umuvq/Wo79ereAjPpPUM=
Message-ID: <2a0fbc590504101627651755ab@mail.gmail.com>
Date: Mon, 11 Apr 2005 01:27:41 +0200
From: Julien Wajsberg <julien.wajsberg@gmail.com>
Reply-To: Julien Wajsberg <julien.wajsberg@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: How's the nforce4 support in Linux?
In-Reply-To: <Pine.LNX.4.61.0504060737130.21548@chaos.analogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <2a0fbc59050325145935a05521@mail.gmail.com>
	 <2a0fbc5905040506422fbf6356@mail.gmail.com>
	 <Pine.LNX.4.61.0504050957400.15886@chaos.analogic.com>
	 <2a0fbc59050405155815666e8d@mail.gmail.com>
	 <Pine.LNX.4.61.0504060737130.21548@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 6, 2005 1:41 PM, Richard B. Johnson <linux-os@analogic.com> wrote:
>
> How would you know?  Windows will just run it as PIOW and be done
> with it.
Yes, but there's a way to know which mode you're using (maybe not
precisely, but at least PIO vs DMA).

> Did you ever try to copy a large file in XP? Try it.
> Try the same thing in linux on the same hardware. You don't need
> a stop-watch. On Win-XP, a 10 megabyte file (hardly large) takes
> about 10 seconds. That's 1 megabyte/second. Linux tries to be
> a bit faster.

Usually, I only have Linux on any hardware I have ;) And there is no
point comparing these things here...

--
Julien

PS: Sorry Richard, I forgot my "reply to all" button...
