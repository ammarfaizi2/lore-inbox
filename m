Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWIXVdD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWIXVdD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Sep 2006 17:33:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbWIXVdD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Sep 2006 17:33:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.171]:1404 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932154AbWIXVdB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Sep 2006 17:33:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=Hy+L0XdScZTktc7oW5KJUtv7fCLKHph7Xm3E1OsTuOHyq8CMPTiOT6B4DmLGMAJaxIm3ge7RxF/SdTOFvfkX/TMZMp1gN+8jepjczvc6myp5ScQHlbMzE4qmC9euoe8tn94ujIwyQdKEGdXe5B6X5BWh2Zqz4WgG/YrDqj2modI=
Message-ID: <4516F97E.6040904@gmail.com>
Date: Sun, 24 Sep 2006 23:32:23 +0159
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Neil Whelchel <koyama@firstlight.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic with two BTTV cards
References: <Pine.LNX.4.44.0609232118180.29847-100000@kishna.firstlight.net>
In-Reply-To: <Pine.LNX.4.44.0609232118180.29847-100000@kishna.firstlight.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neil Whelchel wrote:
> Hello,
> I have a Dual Xeon box with a Broadcom CIOB-X2 chipset with two BT878
> cards installed. All is well until I start using both cards at the same
> time. After a random period of time (5 min to 10 hr) I get a random kernel
> panic that completely freezes the machine. This has never occurred when I
> am
> using only one of the two installed cards at a time. I have also tried
> this with TB848 cards as well with the same problem.
> This problem has persisted through every version of the kernel I have
> tested so far.
> 2.6.12 SMP
> 2.6.13.1 SMP
> 2.6.14.3 SMP
> 2.6.17.11 SMP
> I have tried all of these with Preemption and no Preemption.
> Any thoughts?

Post panic output, please.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
