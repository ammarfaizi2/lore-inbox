Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbRFMN7V>; Wed, 13 Jun 2001 09:59:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263414AbRFMN7K>; Wed, 13 Jun 2001 09:59:10 -0400
Received: from pizda.ninka.net ([216.101.162.242]:56741 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263257AbRFMN67>;
	Wed, 13 Jun 2001 09:58:59 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.29087.300044.852763@pizda.ninka.net>
Date: Wed, 13 Jun 2001 06:58:55 -0700 (PDT)
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Keith Owens <kaos@ocs.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
In-Reply-To: <3B276F31.8BBF06AF@mandrakesoft.com>
In-Reply-To: <8272.992434020@ocs4.ocs-net>
	<15143.22734.747077.588558@pizda.ninka.net>
	<3B276F31.8BBF06AF@mandrakesoft.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jeff Garzik writes:
 > how to do this in foo.S code?

foo.S goes through the preprocessor already.

Later,
David S. Miller
davem@redhat.com
