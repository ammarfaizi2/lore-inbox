Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265680AbSIRGst>; Wed, 18 Sep 2002 02:48:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265683AbSIRGst>; Wed, 18 Sep 2002 02:48:49 -0400
Received: from dhcp101-dsl-usw4.w-link.net ([208.161.125.101]:64657 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S265680AbSIRGsr>;
	Wed, 18 Sep 2002 02:48:47 -0400
Message-ID: <3D8822F4.6060201@candelatech.com>
Date: Tue, 17 Sep 2002 23:53:40 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ben Greear <greearb@candelatech.com>
CC: "'netdev@oss.sgi.com'" <netdev@oss.sgi.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]  Networking:  send-to-self
References: <3D88217A.6070702@candelatech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Greear wrote:
> This patch allows one to use the SO_BINDTODEVICE and a new ioctl against
> net_device objects to send and receive regular routed traffic between two

Gack, sorry for the last patch..it seems I screwed up the
patch process somehow.  Plz don't apply it as is!

-- 
Ben Greear <greearb@candelatech.com>       <Ben_Greear AT excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear


