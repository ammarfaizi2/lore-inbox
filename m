Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261493AbTC3QpM>; Sun, 30 Mar 2003 11:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261496AbTC3QpM>; Sun, 30 Mar 2003 11:45:12 -0500
Received: from main.gmane.org ([80.91.224.249]:18316 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id <S261493AbTC3QpK>;
	Sun, 30 Mar 2003 11:45:10 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: [patch/2.5.66] update of unified zoran driver
Date: Sun, 30 Mar 2003 11:52:09 -0500
Message-ID: <3E8720B9.8030101@myrealbox.com>
References: <1048984516.1316.25.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ronald Bultje wrote:
[SNIP]
> Anyone willing to take this beast? Gerd? Alan?
> 
> Thanks,
> 
> Ronald
> 

Does your update take into account the recent changes to the 
i2c framework on 2003-03-21 & 2003-03-22?  You might want to 
also provide an update patch which will apply cleanly after 
those changes to make it easier to test...

Cheers,
Nicholas


