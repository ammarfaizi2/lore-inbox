Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264824AbRFSWt4>; Tue, 19 Jun 2001 18:49:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264825AbRFSWtq>; Tue, 19 Jun 2001 18:49:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:57472 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264824AbRFSWtm>;
	Tue, 19 Jun 2001 18:49:42 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15151.55017.371775.585016@pizda.ninka.net>
Date: Tue, 19 Jun 2001 15:49:13 -0700 (PDT)
To: Dax Kelson <dkelson@gurulabs.com>
Cc: Ben Greear <greearb@candelatech.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: Should VLANs be devices or something else?
In-Reply-To: <Pine.LNX.4.33.0106191641150.17061-100000@duely.gurulabs.com>
In-Reply-To: <3B2FCE0C.67715139@candelatech.com>
	<Pine.LNX.4.33.0106191641150.17061-100000@duely.gurulabs.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dax Kelson writes:
 > On Tue, 19 Jun 2001, Ben Greear wrote:
 > > Should VLANs be devices or some other thing?
 > 
 > I would vote that VLANs be devices.
 > 
 > Conceptually, VLANs as network devices is a no brainer.

Conceptually, svr4 streams are a beautiful and elegant
mechanism. :-)

Technical implementation level concerns need to be considered
as well as "does it look nice".

Later,
David S. Miller
davem@redhat.com
