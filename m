Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269293AbUJQU1p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269293AbUJQU1p (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 16:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269286AbUJQUZ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 16:25:57 -0400
Received: from smtp3.netcabo.pt ([212.113.174.30]:33676 "EHLO smtp.netcabo.pt")
	by vger.kernel.org with ESMTP id S269289AbUJQUZt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 16:25:49 -0400
Message-ID: <32786.192.168.1.5.1098044615.squirrel@192.168.1.5>
In-Reply-To: <20041017192445.GA32443@elte.hu>
References: <1097888438.6737.63.camel@krustophenia.net>
    <1097894120.31747.1.camel@krustophenia.net>
    <20041016064205.GA30371@elte.hu>
    <1097917325.1424.13.camel@krustophenia.net>
    <20041016103608.GA3548@elte.hu>
    <32801.192.168.1.5.1098018846.squirrel@192.168.1.5>
    <20041017132107.GA18462@elte.hu>
    <32793.192.168.1.5.1098023139.squirrel@192.168.1.5>
    <20041017164743.GA26350@elte.hu>
    <32792.192.168.1.5.1098039918.squirrel@192.168.1.5>
    <20041017192445.GA32443@elte.hu>
Date: Sun, 17 Oct 2004 21:23:35 +0100 (WEST)
Subject: Re: [patch] Real-Time Preemption, -VP-2.6.9-rc4-mm1-U3
From: "Rui Nuno Capela" <rncbc@rncbc.org>
To: "Ingo Molnar" <mingo@elte.hu>
Cc: "Lee Revell" <rlrevell@joe-job.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       mark_h_johnson@raytheon.com, "K.R. Foley" <kr@cybsft.com>,
       "Daniel Walker" <dwalker@mvista.com>, "Bill Huey" <bhuey@lnxw.com>,
       "Andrew Morton" <akpm@osdl.org>, "Adam Heath" <doogie@debian.org>,
       "Lorenzo Allegrucci" <l_allegrucci@yahoo.it>,
       "Andrew Rodland" <arodland@entermail.net>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-OriginalArrivalTime: 17 Oct 2004 20:25:47.0405 (UTC) FILETIME=[7C68E3D0:01C4B487]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
>
> * Rui Nuno Capela <rncbc@rncbc.org> wrote:
>
>> BTW, stack overflows wasn't supposed to be pin-pointed when one has
>> CONFIG_DEBUG_STACKOVERFLOW=y ???
>
> there were some signs of it:
>
>   minicom.cap.5:do_IRQ: stack overflow: 504
>

Yeah. And that was the one who went away in a never ending trace...
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

