Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264552AbRFMGYS>; Wed, 13 Jun 2001 02:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264553AbRFMGX7>; Wed, 13 Jun 2001 02:23:59 -0400
Received: from zeus.kernel.org ([209.10.41.242]:23006 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264552AbRFMGXw>;
	Wed, 13 Jun 2001 02:23:52 -0400
Date: Tue, 12 Jun 2001 23:22:56 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Craig Lyons <craigl@promise.com>
cc: linux-kernel@vger.kernel.org
Subject: [craigl@promise.com: Getting A Patch Into The Kernel] (fwd)
Message-ID: <Pine.LNX.4.10.10106122307580.9287-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Mr. Craig Lyons,

I do not want or need your company's patches, period.
I will not take or accept or approve of any dirty code that allows the a
poorly written binary driver that can not control its ISR and it
interferes irresponsiblily with the native ATA driver.

These are the words from your dear "Linus Chen".

Oh answer your voice mail, I left you a message.

Regards,

Andre Hedrick
Linux ATA Development

----- Forwarded message from Craig Lyons <craigl@promise.com> -----

        X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
        Sender: linux-kernel-owner@vger.kernel.org
        Message-ID: <005101c0f38f$e2000960$bd01a8c0@promise.com>
        From: "Craig Lyons" <craigl@promise.com>
        Date:	Tue, 12 Jun 2001 15:34:43 -0700
        To: <linux-kernel@vger.kernel.org>
        Subject: Getting A Patch Into The Kernel
        Importance: Normal

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

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/


