Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263411AbUDUQ0O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263411AbUDUQ0O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 12:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbUDUQ0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 12:26:13 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:19906 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263411AbUDUQ0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 12:26:11 -0400
Message-ID: <4086A077.2000705@nortelnetworks.com>
Date: Wed, 21 Apr 2004 12:25:27 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: netdev@oss.sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
References: <40869267.30408@nortelnetworks.com> <Pine.LNX.4.53.0404211153550.1169@chaos>
In-Reply-To: <Pine.LNX.4.53.0404211153550.1169@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:

> The vulnerabilities were discussed on US news reports as being
> like somebody discovered they could disconnect your electricity
> if they had some wire-cutters.
> 
> Those guys in the UK just don't have anything else to do! It
> seems that they discovered that if you tap-into some network
> physical media you could disrupt it!

The impression I got was that some equipment was much more vulnerable 
due to having a) massive windows, and b) using sequential source ports, 
making it much easier to guess even if you can't tap the line.

Chris
