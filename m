Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135264AbRDRTXX>; Wed, 18 Apr 2001 15:23:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135265AbRDRTXN>; Wed, 18 Apr 2001 15:23:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17811 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135264AbRDRTXI>;
	Wed, 18 Apr 2001 15:23:08 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15069.59729.139404.133701@pizda.ninka.net>
Date: Wed, 18 Apr 2001 12:21:53 -0700 (PDT)
To: Martin Gadbois <martin.gadbois@colubris.com>
Cc: linux-kernel@vger.kernel.org, ak@muc.de, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] IP forwarded checksum, kernel 2.2.18-19
In-Reply-To: <3ADDB0D1.826456E2@colubris.com>
In-Reply-To: <3ADDB0D1.826456E2@colubris.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Martin Gadbois writes:
 > Hi there!
 > I realized that some tests were failing due to dropped IP packets. I
 > traced and discovered the following:

Thanks, I've put your patch into my 2.2.x source and will
push this to Alan once he starts doing 2.2.20pre patches.

Later,
David S. Miller
davem@redhat.com
