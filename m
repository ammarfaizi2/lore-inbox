Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750881AbVILSTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750881AbVILSTW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 14:19:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750893AbVILSTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 14:19:22 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:23819 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP
	id S1750881AbVILSTU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 14:19:20 -0400
Message-ID: <4325C825.9060209@tmr.com>
Date: Mon, 12 Sep 2005 14:25:41 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: abonilla@linuxwireless.org
CC: ieee80211-devel@lists.sourceforge.net,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Git broken for IPW2200
References: <1126143695.5402.11.camel@localhost.localdomain>
In-Reply-To: <1126143695.5402.11.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alejandro Bonilla Beeche wrote:
> Hi,
> 
> 	Where does one report this? I was building Linus Git tree as per I
> updated it at 09/07/2005 7:00PM PDT and got this while compiling.
> 
> Where do I report this?
> 
> Debian unstable updated at same time.
> 
> it looks like ipw2200 is thinking that ieee80211 is not compiled in, but
> I did select it as a module?
> 
I got the same error, and git11 did build, although it works exactly as 
well as ever, which is to say not at all.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
