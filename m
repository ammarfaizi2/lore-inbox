Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265279AbRFUWzA>; Thu, 21 Jun 2001 18:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265278AbRFUWyu>; Thu, 21 Jun 2001 18:54:50 -0400
Received: from cx97923-a.phnx3.az.home.com ([24.9.112.194]:62938 "EHLO
	grok.yi.org") by vger.kernel.org with ESMTP id <S265279AbRFUWyi>;
	Thu, 21 Jun 2001 18:54:38 -0400
Message-ID: <3B327B2A.26DBC2C4@candelatech.com>
Date: Thu, 21 Jun 2001 15:54:34 -0700
From: Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Guy Van Den Bergh <guy.vandenbergh@pandora.be>
CC: linux-kernel@vger.kernel.org, Holger Kiehl <Holger.Kiehl@dwd.de>,
        "David S. Miller" <davem@redhat.com>,
        VLAN Mailing List <vlan@Scry.WANfear.com>,
        "vlan-devel (other)" <vlan-devel@lists.sourceforge.net>,
        Lennert <buytenh@gnu.org>, Gleb Natapov <gleb@nbase.co.il>
Subject: Re: [Vlan-devel] Should VLANs be devices or something else?
In-Reply-To: <Pine.LNX.4.30.0106191016200.27487-100000@talentix.dwd.de> <3B2FCE0C.67715139@candelatech.com> <3B3270C4.3080103@pandora.be>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Guy Van Den Bergh wrote:
> 
> Maybe this has been discussed already, but what about integration
> with the bridging code? Is it possible to add add a vlan interface to a
> bridge? In other words, can you bridge between one or more regular
> interfaces and a vlan?
> 
> Regards,
> Guy

I hear it does work with the bridging code, just as you would expect
it to.  I have not tried it personally...

Ben

-- 
Ben Greear <greearb@candelatech.com>          <Ben_Greear@excite.com>
President of Candela Technologies Inc      http://www.candelatech.com
ScryMUD:  http://scry.wanfear.com     http://scry.wanfear.com/~greear
