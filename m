Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262029AbUDJObS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 10:31:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262041AbUDJObS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 10:31:18 -0400
Received: from mail.fdk-filmhaus.de ([212.184.83.66]:42435 "EHLO
	mail.fdk-filmhaus.de") by vger.kernel.org with ESMTP
	id S262029AbUDJObR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 10:31:17 -0400
Message-ID: <1152.217.4.101.91.1081607473.squirrel@mail.fdk-filmhaus.de>
In-Reply-To: <m33c7dw3eb.fsf@averell.firstfloor.org>
References: <1Gyjw-2iM-9@gated-at.bofh.it>
    <m33c7dw3eb.fsf@averell.firstfloor.org>
Date: Sat, 10 Apr 2004 16:31:13 +0200 (CEST)
Subject: Re: powernow-k8: broken PSB
From: "Christoph Terhechte" <ct@fdk-berlin.de>
To: "Andi Kleen" <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> You have ACPI disabled right?

No, I have it enabled. Another AMD64 user sent me his kernel .config which
I tried, and it worked. Then I slowly went back to my original kernel
.config step by step to find out what the culprit was. I was amazed to
find out that powernow-k8 still worked after I had gone back to my
original .config (took me half a day and about 50 reboots). Impossible for
me to say what triggered this change of mind of my system, but it works
perfectly now without me changing anything.

Sometimes I feel that even in the digital world there are things beyond
explanation ;-)

-- 
Christoph Terhechte <ct@fdk-berlin.de>
International Forum of New Cinema
Potsdamer Strasse 2
D-10785 Berlin
Tel: +49-30-269.55.200
Fax: +49-30-269.55.222

