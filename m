Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291043AbSBGBXE>; Wed, 6 Feb 2002 20:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291042AbSBGBWw>; Wed, 6 Feb 2002 20:22:52 -0500
Received: from ip68-3-104-241.ph.ph.cox.net ([68.3.104.241]:44718 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S291027AbSBGBWt>;
	Wed, 6 Feb 2002 20:22:49 -0500
Message-ID: <3C61D6E4.2050705@candelatech.com>
Date: Wed, 06 Feb 2002 18:22:44 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.4) Gecko/20011019 Netscape6/6.2
X-Accept-Language: en-us
MIME-Version: 1.0
To: harish.vasudeva@amd.com
CC: linux-kernel@vger.kernel.org
Subject: Re: Need Info on EthernetDrivers
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F04F2806A@caexmta9.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

VLAN tagging code can be found in linux/net/8021q/
See: http://www.candelatech.com/~greear/vlan.html for
more details.

harish.vasudeva@amd.com wrote:

> 	Hi,
> 
> 	 does Linux support TCP Segmentation & VLAN tagging for network drivers? If so, where can i get the related docs?
> 
> 	thanx
> 	HARISH V


-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


