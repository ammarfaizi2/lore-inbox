Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291773AbSBTL1z>; Wed, 20 Feb 2002 06:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291775AbSBTL1h>; Wed, 20 Feb 2002 06:27:37 -0500
Received: from pizda.ninka.net ([216.101.162.242]:2688 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S291771AbSBTL1Z>;
	Wed, 20 Feb 2002 06:27:25 -0500
Date: Wed, 20 Feb 2002 03:25:19 -0800 (PST)
Message-Id: <20020220.032519.41641488.davem@redhat.com>
To: brett@bad-sports.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.5 scsi changes : qlogicfas.c fixed
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0202202155190.2600-200000@bad-sports.com>
In-Reply-To: <Pine.LNX.4.44.0202202155190.2600-200000@bad-sports.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Brett <brett@bad-sports.com>
   Date: Wed, 20 Feb 2002 22:00:37 +1100 (EST)
   
   Once again, thanks to people messing with the scsi layer, I'm forced to 
   attempt to fix this driver, which it seems I'm the only one using :)

The esp.c sources would be a better basis for writing a driver to
drive this chip, BTW.

qlogicfas.c is rarely if ever used (as you contend) and doesn't work
at all in the rare case we know it is used (as you also contend :-)

