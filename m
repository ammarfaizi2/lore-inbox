Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312855AbSCVVq3>; Fri, 22 Mar 2002 16:46:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312858AbSCVVqT>; Fri, 22 Mar 2002 16:46:19 -0500
Received: from pizda.ninka.net ([216.101.162.242]:56038 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312855AbSCVVqI> convert rfc822-to-8bit;
	Fri, 22 Mar 2002 16:46:08 -0500
Date: Fri, 22 Mar 2002 13:42:08 -0800 (PST)
Message-Id: <20020322.134208.64317316.davem@redhat.com>
To: pasik@iki.fi
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BETA-0.97] Eigth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0203222333520.10668-100000@edu.joroinen.fi>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pasi Kärkkäinen <pasik@iki.fi>
   Date: Fri, 22 Mar 2002 23:37:34 +0200 (EET)
   
   How about vlans.. should it say something about enabling hardware vlan
   tagging when I configure some vlans?

It just should work.  The VLAN layer might print something out,
but the tg3 driver won't have anything interesting to say.
