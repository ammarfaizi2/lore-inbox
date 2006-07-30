Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751407AbWG3WZS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbWG3WZS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 18:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751417AbWG3WZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 18:25:17 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:55868 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751407AbWG3WZQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 18:25:16 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:in-reply-to:x-mimeole:thread-index;
        b=OfxKyJKOJaD2s2Ftz/2E2TiQ/zKt/51FkDZ2xyNjJTQKrioKUnYuhUDpHvTaYa8fAmrfqbffqajAxKA0CuqsIq+zCAbEcQJZgwvJBuO8hlaI9/DPGTE1jCD0zPLn6KWZPw5VALV5/fhuq1CZ2mezlUnTKpDbvIGyDegYZeu79wU=
From: "Hua Zhong" <hzhong@gmail.com>
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>
Cc: "'Bill Davidsen'" <davidsen@tmr.com>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: RE: suspend2 merge history [was Re: the " 'official' point of view" expressed by kernelnewbies.org regarding reiser4 inclusion]
Date: Sun, 30 Jul 2006 15:25:49 -0700
Message-ID: <00c801c6b427$20d545d0$0200a8c0@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
In-Reply-To: <200607300054.18231.rjw@sisk.pl>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
Thread-Index: AcazYhSTT8Kh8rT/QnypMc4RzbI7KAAPW3nA
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I don't _blame_ drivers.  I only wanted to say this: "If 
> Nigel knows that some drivers need to be fixed and he has 
> working fixes for these drivers, he should have submitted 
> these fixes for merging instead of just keeping them in 
> suspend2".  Period.
> 
> If I know of a fix for a driver, I always do my best to make 
> sure the fix will get considered for merging at least.  The 
> problem is I'm not a driver expert and I can't provide the 
> fixes myself.

Suspend2 patch is open source. You can always take a look. Moreover, if someone claims suspend2 isn't ready for merge, or the
patches Nigal has submitted aren't up to standards, one would guess he'd have done so already. So I don't understand what the above
means. Have you asked Nigal whether he had any driver fixes? If you guys are really working together, isn't it very easy to do?

> And that's very true.  For example, the suspend-to-ram 
> doesn't fully work on my own box and I'm not sure it ever 
> will.  However, that's not a fault of anyone who works on 
> this, just broken BIOS and the lack of documentation.
> This is worrisome and many people work on improving these 
> things, but the matter is notoriously difficult.

I'm not exactly an expert, but I don't think suspend-to-ram is more difficult than suspend-to-disk (probably quite the contrary),
and there are a lot in common.

I am sorry that you find some of the comments offensive, but there isn't really anything personal. It's merely a reflection of the
frustration from linux users wrt suspend OVER THE YEARS. I know you guys are hard working, but in the end it's a top-quality suspend
that counts, and people's patience has been wearing out, especially when there has been an out-of-tree implementation available for
a long time already. Everyone wants to see the current maintainers take a more humble and proactive attitude when working with Nigal
instead of just dismissing his "bad design" and bashing his patch quality. It's so easy to block someone's initiative than making it
better.

Hua

