Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751281AbWGPV10@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWGPV10 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jul 2006 17:27:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751238AbWGPV10
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jul 2006 17:27:26 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:38419 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1751281AbWGPV1Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jul 2006 17:27:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=bNKKQk2sQvalDESJiDOR/Iel7HYDujsnpyROGLYfr2nY/G1XvZlDu+1aSn12tJ8/ZRW8uQS4m4+uH1zDErkzAK9kgXLOTIP+rx3qPhyvPYDd6gFzRDzKhbluHan4fgSmwwsXcEvu94W1x4pnL43isYvlCKUZ03znzDh9z/JJOpY=
Message-ID: <6bffcb0e0607161427x5146caa9v3b11752a6d2bb20d@mail.gmail.com>
Date: Sun, 16 Jul 2006 23:27:24 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Krzysztof Halasa" <khc@pm.waw.pl>
Subject: Re: 2.6.17.3 kernel panic
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <m3odvpbblv.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m3psg5a5lp.fsf@defiant.localdomain>
	 <6bffcb0e0607160926h25ae8171kf2785f731a62fb6b@mail.gmail.com>
	 <m3lkqta4h9.fsf@defiant.localdomain>
	 <6bffcb0e0607160949j7b38c98ci323c62d9b35e469a@mail.gmail.com>
	 <m3odvpbblv.fsf@defiant.localdomain>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/06, Krzysztof Halasa <khc@pm.waw.pl> wrote:
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> writes:
>
> > Have you tried memtest86+ (http://www.memtest.org/)?
>
> Both that and memtest86, several times. Will run it again, though.

So if you don't have any bad blacks... this it similar to my bug
report http://www.ussg.iu.edu/hypermail/linux/kernel/0606.3/index.html#2558

As Dave Jones has said "Looks like a use after free".

> --
> Krzysztof Halasa
>

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/wiki/)
