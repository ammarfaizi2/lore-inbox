Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312217AbSCRGqx>; Mon, 18 Mar 2002 01:46:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312219AbSCRGqo>; Mon, 18 Mar 2002 01:46:44 -0500
Received: from pizda.ninka.net ([216.101.162.242]:3260 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S312217AbSCRGqc>;
	Mon, 18 Mar 2002 01:46:32 -0500
Date: Sun, 17 Mar 2002 22:43:16 -0800 (PST)
Message-Id: <20020317.224316.116607569.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: rusty@rustcorp.com.au, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org, rgooch@ras.ucalgary.ca
Subject: Re: bit ops on unsigned long?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C958332.4050508@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Mon, 18 Mar 2002 01:03:30 -0500
   
   Even if the port doesn't support CONFIG_PREEMPT at all?
   
Linus and myself plan on using it for something else
(something akin to a softirq+otherstuff count).
