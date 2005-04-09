Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261424AbVDIXPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261424AbVDIXPS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 19:15:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVDIXNf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 19:13:35 -0400
Received: from terminus.zytor.com ([209.128.68.124]:51370 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261424AbVDIXMp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 19:12:45 -0400
Message-ID: <42586168.4030002@zytor.com>
Date: Sat, 09 Apr 2005 16:12:40 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andre Tomt <andre@tomt.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Status of new kernel.org servers
References: <d39kad$a33$1@terminus.zytor.com> <425860A1.8050209@tomt.net>
In-Reply-To: <425860A1.8050209@tomt.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andre Tomt wrote:
> H. Peter Anvin wrote:
> 
>> For those of you that are interested...
> 
> <snip>
> 
> I kind of sort of miss the load and bandwidth statistics on the 
> kernel.org front page. Did they just go boring now with sufficient 
> hardware resources? :-)

No; the issue there is that with multiple servers we have to change the 
way they're generated and distributed.  Nathan Laredo is working on 
that, but it's so obviously not a high priority item.

	-hpa
