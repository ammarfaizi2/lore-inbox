Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUG1VeP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUG1VeP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:34:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264658AbUG1VeP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:34:15 -0400
Received: from ns1.lanforge.com ([66.165.47.210]:64737 "EHLO www.lanforge.com")
	by vger.kernel.org with ESMTP id S264640AbUG1VeC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:34:02 -0400
Message-ID: <41081BC4.6040607@candelatech.com>
Date: Wed, 28 Jul 2004 14:33:56 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@redhat.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PATCH: VLAN support for 3c59x/3c90x
References: <20040728124256.GA31246@devserv.devel.redhat.com>
In-Reply-To: <20040728124256.GA31246@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> This adds VLAN support to the 3c59x/90x series hardware.
> 
> Stefan de Konink ported this code from the 2.4 VLAN patches and tested it
> extensively. I cleaned up the ifdefs and fixed a problem with bracketing
> that made older cards fail.

I am sure this will be appreciated by the VLAN users!

Also, do you happen to know how large of an MTU these cards
can support?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

