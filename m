Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135758AbRDSXpW>; Thu, 19 Apr 2001 19:45:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135760AbRDSXpN>; Thu, 19 Apr 2001 19:45:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19084 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S135758AbRDSXo4>;
	Thu, 19 Apr 2001 19:44:56 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15071.30776.914468.900710@pizda.ninka.net>
Date: Thu, 19 Apr 2001 16:43:52 -0700 (PDT)
To: "D.W.Howells" <dhowells@astarte.free-online.co.uk>
Cc: torvalds@transmeta.com, dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] generic rw_semaphores, compile warnings patch
In-Reply-To: <01042000331901.01311@orion.ddi.co.uk>
In-Reply-To: <01042000331901.01311@orion.ddi.co.uk>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


D.W.Howells writes:
 > This patch (made against linux-2.4.4-pre4) gets rid of some warnings obtained 
 > when using the generic rwsem implementation.

Have a look at pre5, this is already fixed.

Later,
David S. Miller
davem@redhat.com
