Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264113AbUDVPni@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbUDVPni (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 11:43:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264148AbUDVPni
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 11:43:38 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:14277 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264113AbUDVPnh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 11:43:37 -0400
Message-ID: <4087E7FB.7000400@nortelnetworks.com>
Date: Thu, 22 Apr 2004 11:42:51 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: alex@pilosoft.com
CC: jamal <hadi@cyberus.ca>, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: tcp vulnerability?  haven't seen anything on it here...
References: <Pine.LNX.4.44.0404221030240.2738-100000@paix.pilosoft.com>
In-Reply-To: <Pine.LNX.4.44.0404221030240.2738-100000@paix.pilosoft.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alex@pilosoft.com wrote:

> Nevertheless, number of packets to kill the session is still *large* 
> (under "best-case" for attacker, you need to send 2^30 packets)...

I though the whole point of this vulnerability was that you "only" needed to send 64K packets, not 2^30.

Chris
