Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261699AbUKOU1d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261699AbUKOU1d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Nov 2004 15:27:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbUKOU1d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Nov 2004 15:27:33 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:44686 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261699AbUKOU1Z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Nov 2004 15:27:25 -0500
Message-ID: <41991200.2@tmr.com>
Date: Mon, 15 Nov 2004 15:30:56 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?UTF-8?B?TWFyY2luIEfCs29nb3dza2k=?= <marcin.glogowski@interia.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: help - how to determine socond memory bank
References: <20041112121950.E6B58A4169@poczta.interia.pl>
In-Reply-To: <20041112121950.E6B58A4169@poczta.interia.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcin Głogowski wrote:
> hi,
> I need help.
> I have linux kernel 2.4.21 and Cirrus EP9315 motherboard.
> I need somehow to enable second memory bank which exists in my motherboard, but Linux doesnt recognize it.
> Wchich file should I modify to make Linux kernel able to see all of my memory?
> Very thank you for help.
> PS:
> I cannot enable discontinous memory, because my Cirrus patch doesnt not support it.
> 
> ----------------------------------------------------------------------
> Ponad 400 tysiecy facetow szuka przyjaciolki, a moze czegos wiecej... 
> 
>>>>http://link.interia.pl/f183b

Have you looked at the memmap= parameter?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
