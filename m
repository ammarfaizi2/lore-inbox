Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293159AbSCEOGH>; Tue, 5 Mar 2002 09:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293151AbSCEOFs>; Tue, 5 Mar 2002 09:05:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:1154 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S293133AbSCEOFb> convert rfc822-to-8bit;
	Tue, 5 Mar 2002 09:05:31 -0500
Date: Tue, 05 Mar 2002 06:03:23 -0800 (PST)
Message-Id: <20020305.060323.99455532.davem@redhat.com>
To: linux-kernel@vger.kernel.org, tlan@stud.ntnu.no
Cc: jgarzik@mandrakesoft.com, linux-net@vger.kernel.org
Subject: Re: [BETA-0.95] Sixth test release of Tigon3 driver
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020305150204.A7174@stud.ntnu.no>
In-Reply-To: <20020305143519.A1780@stud.ntnu.no>
	<20020305.055204.44939648.davem@redhat.com>
	<20020305150204.A7174@stud.ntnu.no>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Thomas Langås <tlan@stud.ntnu.no>
   Date: Tue, 5 Mar 2002 15:02:04 +0100
   
   > Also, can you try both changing the MTU during the
   > initial up of the interface and later after the
   > interface is up already?  Thanks.
   
   Did that, none work.

How are you setting the mtu, with:

/sbin/ifconfig ${DEV} mtu 9000

or something like that?  Hmmm...

