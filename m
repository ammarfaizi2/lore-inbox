Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129183AbQLAOQx>; Fri, 1 Dec 2000 09:16:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129210AbQLAOQn>; Fri, 1 Dec 2000 09:16:43 -0500
Received: from salisbury.labs.futuretv.com ([194.216.164.17]:21754 "EHLO
	mail.futuretv.com") by vger.kernel.org with ESMTP
	id <S129183AbQLAOQd>; Fri, 1 Dec 2000 09:16:33 -0500
X-Mailer: exmh version 2.1.1 10/15/1999 (debian)
To: Russell King <rmk@arm.linux.org.uk>
cc: cw@f00f.org (Chris Wedgwood), romieu@ensta.fr,
        lists@cyclades.com (Ivan Passos), linux-kernel@vger.kernel.org,
        netdev@oss.sgi.com
Subject: Re: [RFC] Configuring synchronous interfaces in Linux 
In-Reply-To: Your message of "Fri, 01 Dec 2000 12:07:08 GMT."
             <200012011207.eB1C78523251@flint.arm.linux.org.uk> 
From: Philip Blundell <pb@futuretv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Dec 2000 13:44:21 +0000
Message-Id: <E141qU9-0005Xr-00@pig.labs.futuretv.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <200012011207.eB1C78523251@flint.arm.linux.org.uk>, Russell King wri
tes:
>We already have a standard interface for this, but many drivers do not
>support it.  Its called "ifconfig eth0 media xxx":

The Ethtool interface is rather better.

p.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
