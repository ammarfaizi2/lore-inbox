Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263836AbRFLXG0>; Tue, 12 Jun 2001 19:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263834AbRFLXGR>; Tue, 12 Jun 2001 19:06:17 -0400
Received: from [205.185.57.35] ([205.185.57.35]:13843 "EHLO mail.promise.com")
	by vger.kernel.org with ESMTP id <S263793AbRFLXF5>;
	Tue, 12 Jun 2001 19:05:57 -0400
Reply-To: <craigl@promise.com>
From: "Craig Lyons" <craigl@promise.com>
To: <linux-kernel@vger.kernel.org>
Subject: Getting A Patch Into The Kernel
Date: Tue, 12 Jun 2001 15:34:43 -0700
Message-ID: <005101c0f38f$e2000960$bd01a8c0@promise.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

My name is Craig Lyons and I am the marketing manager at Promise Technology.
We have a question and are hoping you can point us in the right direction.
In the 2.4 kernel there is support for some of our products (Ultra 66, Ultra
100, etc.). As you may or may not know, our Ultra family of controllers
(which are just standard IDE controllers and do not have RAID) use the same
ASIC on them as our FastTrak RAID controllers do. The 2.4 kernel will
recognize our Ultra family of controllers, but there is a problem in that a
FastTrak will not be recognized as a FastTrak, but as an Ultra.
Consequently, the array on the FastTrak is not recognized as an array, but
instead each disk is seen individually, and the users data cannot be
properly accessed. We have a patch that fixes this and are wondering if it
is possible to get this patch into the kernel, and if so, how this would be
done?

I apologize if this is the incorrect e-mail to be making this request to. If
this is not the correct address to be posting this message, any assistance
as to where it should be directed would be greatly appreciated.

Regards,

Craig


Craig Lyons
Marketing Manager
Promise Technology
1460 Koll Circle
San Jose, CA 95112
USA
Voice - 408-452-0948 ext. 241
Fax - 408-452-1534
craigl@promise.com
http:\\www.promise.com

