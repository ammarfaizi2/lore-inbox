Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273049AbTGaNuR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 09:50:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273050AbTGaNuQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 09:50:16 -0400
Received: from routeree.utt.ro ([193.226.8.102]:26060 "EHLO klesk.etc.utt.ro")
	by vger.kernel.org with ESMTP id S273049AbTGaNuM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 09:50:12 -0400
Message-ID: <23496.194.138.39.55.1059659754.squirrel@webmail.etc.utt.ro>
Date: Thu, 31 Jul 2003 16:55:54 +0300 (EEST)
Subject: Re: [PATCH] O11int for interactivity
From: "Szonyi Calin" <sony@etc.utt.ro>
To: <kernel@kolivas.org>
In-Reply-To: <200307301108.53904.kernel@kolivas.org>
References: <200307301038.49869.kernel@kolivas.org>
        <200307301055.23950.kernel@kolivas.org>
        <200307301108.53904.kernel@kolivas.org>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas said:
> On Wed, 30 Jul 2003 10:55, Con Kolivas wrote:
>> On Wed, 30 Jul 2003 10:38, Con Kolivas wrote:
>> > Update to the interactivity patches. Not a massive improvement but
>> more smoothing of the corners.
>>
> Here is O11.1int which backs out that part. This was only of minor help
> anyway so backing it out still makes the other O11 changes worthwhile.
>
> A full O11.1 patch against 2.6.0-test2 is available on my website.
>

A little bit better than O10 but mplayer still skips frames while
doind a make bzImage in the background

-- 
# fortune
fortune: write error on /dev/null --- please empty the bit bucket


-----------------------------------------
This email was sent using SquirrelMail.
   "Webmail for nuts!"
http://squirrelmail.org/


