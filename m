Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264823AbRFSWqG>; Tue, 19 Jun 2001 18:46:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264827AbRFSWp4>; Tue, 19 Jun 2001 18:45:56 -0400
Received: from fw.gurulabs.com ([209.140.75.26]:26361 "HELO mail.gurulabs.com")
	by vger.kernel.org with SMTP id <S264823AbRFSWpv>;
	Tue, 19 Jun 2001 18:45:51 -0400
Date: Tue, 19 Jun 2001 16:45:49 -0600 (MDT)
From: Dax Kelson <dkelson@gurulabs.com>
To: Ben Greear <greearb@candelatech.com>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Holger Kiehl <Holger.Kiehl@dwd.de>,
        "David S. Miller" <davem@redhat.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: Should VLANs be devices or something else?
In-Reply-To: <3B2FCE0C.67715139@candelatech.com>
Message-ID: <Pine.LNX.4.33.0106191641150.17061-100000@duely.gurulabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Jun 2001, Ben Greear wrote:

> I have had a good discussion with Dave Miller today, and there
> is one outstanding issue to clear up before my 802.1Q VLAN patch may
> be considered for acceptance into the kernel:
>
> Should VLANs be devices or some other thing?

I would vote that VLANs be devices.

Conceptually, VLANs as network devices is a no brainer.

Dax

