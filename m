Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293309AbSCEPF0>; Tue, 5 Mar 2002 10:05:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293288AbSCEPFR>; Tue, 5 Mar 2002 10:05:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16514 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293243AbSCEPFJ> convert rfc822-to-8bit;
	Tue, 5 Mar 2002 10:05:09 -0500
Date: Tue, 05 Mar 2002 07:02:59 -0800 (PST)
Message-Id: <20020305.070259.106438647.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020305151936.C7174@stud.ntnu.no>
In-Reply-To: <20020305.060323.99455532.davem@redhat.com>
	<20020305.060604.68157839.davem@redhat.com>
	<20020305151936.C7174@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Tue, 5 Mar 2002 15:19:36 +0100
   
   I'm going through a switch yes; a Cisco Catalyst 4006.  I can have a chat
   with the networking folks here, but shouldn't the switch fragment the packet
   if it's too big?
   
Switches then would need to understand IP, IPX, Netbeui... :-)

I hear some have tried it for at least IP, and admittedly my
impression of the situation is a bit dated :)
