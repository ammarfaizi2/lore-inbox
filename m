Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293352AbSCAQrQ>; Fri, 1 Mar 2002 11:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293373AbSCAQqt>; Fri, 1 Mar 2002 11:46:49 -0500
Received: from taifun.devconsult.de ([212.15.193.29]:38921 "EHLO
	taifun.devconsult.de") by vger.kernel.org with ESMTP
	id <S293366AbSCAQqU>; Fri, 1 Mar 2002 11:46:20 -0500
Date: Fri, 1 Mar 2002 17:46:19 +0100
From: Andreas Ferber <aferber@techfak.uni-bielefeld.de>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Ben Greear <greearb@candelatech.com>, "David S. Miller" <davem@redhat.com>,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Various 802.1Q VLAN driver patches. [try2]
Message-ID: <20020301174619.A6125@devcon.net>
Mail-Followup-To: Jeff Garzik <jgarzik@mandrakesoft.com>,
	Ben Greear <greearb@candelatech.com>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org,
	linux-net@vger.kernel.org
In-Reply-To: <20020301.072831.120445660.davem@redhat.com> <3C7FA81A.3070602@candelatech.com> <20020301.081110.76328637.davem@redhat.com> <3C7FAC00.4010402@candelatech.com> <3C7FADBB.3A5B338F@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3C7FADBB.3A5B338F@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Mar 01, 2002 at 11:35:07AM -0500
Organization: dev/consulting GmbH
X-NCC-RegID: de.devcon
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 01, 2002 at 11:35:07AM -0500, Jeff Garzik wrote:
> 
> It looks like the eepro100 one, mysterious as it is, is ok.  The others
> I have different plans for:  making them act similar to the recent
> 8139cp changes.

The 3c59x one is available on

http://www.myipv6.de/patches/vlan/3c59x.c-8021q.patch

Andreas
-- 
       Andreas Ferber - dev/consulting GmbH - Bielefeld, FRG
     ---------------------------------------------------------
         +49 521 1365800 - af@devcon.net - www.devcon.net
