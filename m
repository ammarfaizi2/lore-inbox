Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269572AbRHCT6g>; Fri, 3 Aug 2001 15:58:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269575AbRHCT60>; Fri, 3 Aug 2001 15:58:26 -0400
Received: from h224n2fls22o974.telia.com ([213.64.99.224]:29841 "EHLO
	milou.dyndns.org") by vger.kernel.org with ESMTP id <S269572AbRHCT6M>;
	Fri, 3 Aug 2001 15:58:12 -0400
Message-Id: <200108031958.f73JwGf12358@milou.dyndns.org>
X-Mailer: exmh version 2.5_20010730 01/15/2001 with nmh-1.0.4
To: linux-kernel@vger.kernel.org
From: Anders Eriksson <aer-list@mailandnews.com>
Subject: link status changes forwarded to userspace?
In-Reply-To: Your message of "Fri, 03 Aug 2001 12:44:47 PDT."
             <3B6AFF2F.D99F8ECD@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 03 Aug 2001 21:58:16 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
Is it possible to get the link status change (e.g. eth cable inserted in card) 
forwarded to userspace? I'd be cool to auto trigger dhcp on connect and 
silently skip the interface if no cable during boot.

/Anders

