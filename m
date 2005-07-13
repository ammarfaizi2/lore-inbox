Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262226AbVGMTKq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262226AbVGMTKq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 15:10:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbVGMTI0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 15:08:26 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:54024 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S262542AbVGMTIA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 15:08:00 -0400
Message-ID: <42D56759.5090301@tmr.com>
Date: Wed, 13 Jul 2005 15:11:21 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Slootman <paul+nospam@wurtel.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Hdaps-devel] Re: Updating hard disk firmware & parking hard
   disk
References: <20050707171434.90546.qmail@web32604.mail.mud.yahoo.com> <Pine.LNX.4.61.0507131208540.14635@yvahk01.tjqt.qr> <42D4EB21.1060305@grimmer.com> <Pine.LNX.4.61.0507131259480.14635@yvahk01.tjqt.qr> <db33tn$bq5$1@news.cistron.nl>
In-Reply-To: <db33tn$bq5$1@news.cistron.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Slootman wrote:
> Jan Engelhardt  <jengelh@linux01.gwdg.de> wrote:
> 
>>What's the gain in parking the head manually if it's done anyway when the disk 
>>spins down (for whatever reason)?
> 
> 
> It seems you're completely missing the whole point of this discussion,
> which was how to implement the hard disk active protection system that
> IBM offers under windows for its laptops, that will park the disk when
> it detects that e.g. the laptop is falling off a table.

Does that imply that we have software to detect falling off a table?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
