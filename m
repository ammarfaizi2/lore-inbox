Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310138AbSCAVWU>; Fri, 1 Mar 2002 16:22:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310135AbSCAVWK>; Fri, 1 Mar 2002 16:22:10 -0500
Received: from pizda.ninka.net ([216.101.162.242]:33673 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S310133AbSCAVWB>;
	Fri, 1 Mar 2002 16:22:01 -0500
Date: Fri, 01 Mar 2002 13:19:41 -0800 (PST)
Message-Id: <20020301.131941.57275237.davem@redhat.com>
To: greearb@candelatech.com
Cc: jgarzik@mandrakesoft.com, aferber@techfak.uni-bielefeld.de,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org, zab@zabbo.net
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C7FF04D.1090202@candelatech.com>
In-Reply-To: <20020301213458.A30120@devcon.net>
	<3C7FE9B4.441B553@mandrakesoft.com>
	<3C7FF04D.1090202@candelatech.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Fri, 01 Mar 2002 14:19:09 -0700
   
   The subtle difference is that we want to be able to have an MTU 4 bytes
   bigger than the VLAN device's MTU, but we most likely do NOT want
   the rest of the stack to know we are using the higher MTU

Jeff understands this Ben :-)
