Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268920AbRHBNM1>; Thu, 2 Aug 2001 09:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268921AbRHBNMS>; Thu, 2 Aug 2001 09:12:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44988 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S268920AbRHBNMF>;
	Thu, 2 Aug 2001 09:12:05 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15209.20899.731395.581746@pizda.ninka.net>
Date: Thu, 2 Aug 2001 06:12:03 -0700 (PDT)
To: Manfred Bartz <mbartz@optushome.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: setsockopt(..,SO_RCVBUF,..) sets wrong value
In-Reply-To: <20010802103447.992.qmail@optushome.com.au>
In-Reply-To: <20010802103447.992.qmail@optushome.com.au>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Manfred Bartz writes:
 > When I do a setsockopt(..,SO_RCVBUF,..) and then read the value back
 > with getsockopt(), the reported value is exactly twice of what I set.

That's correct.  Please search the list archives to learn why things
behave this way and why they are not going to change.

I wish that this long winded, and often occuring thread not occur
again.

Later,
David S. Miller
davem@redhat.com
