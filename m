Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263003AbVHEMoh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263003AbVHEMoh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 08:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263007AbVHEMof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 08:44:35 -0400
Received: from smtp.bredband2.net ([82.209.166.4]:57945 "EHLO
	smtp.bredband2.net") by vger.kernel.org with ESMTP id S263003AbVHEMof
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 08:44:35 -0400
Message-ID: <42F35F2E.6000100@home.se>
Date: Fri, 05 Aug 2005 14:44:30 +0200
From: =?ISO-8859-1?Q?John_B=E4ckstrand?= <sandos@home.se>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: lockups with netconsole on e1000 on media insertion
References: <42F347D2.7000207@home.se.suse.lists.linux.kernel> <p73ek987gjw.fsf@bragg.suse.de>
In-Reply-To: <p73ek987gjw.fsf@bragg.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> The patch was for 2.6.12, did a quick untested port to 2.6.13rc5.
> 
> -Andi
> 
> Only try a limited number to send packets in netpoll

Thanks, worked nicely!

---
John Bäckstrand
