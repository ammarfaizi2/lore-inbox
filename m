Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263948AbRFMO4Y>; Wed, 13 Jun 2001 10:56:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263967AbRFMO4O>; Wed, 13 Jun 2001 10:56:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:30374 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263948AbRFMOzx>;
	Wed, 13 Jun 2001 10:55:53 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.32501.395951.374796@pizda.ninka.net>
Date: Wed, 13 Jun 2001 07:55:49 -0700 (PDT)
To: Andreas Schwab <schwab@suse.de>
Cc: Keith Owens <kaos@ocs.com.au>, torvalds@transmeta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq
In-Reply-To: <jek82gjv6v.fsf@sykes.suse.de>
In-Reply-To: <15143.29246.712747.936864@pizda.ninka.net>
	<10322.992441398@ocs4.ocs-net>
	<15143.30453.762432.702411@pizda.ninka.net>
	<jek82gjv6v.fsf@sykes.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andreas Schwab writes:
 > "David S. Miller" <davem@redhat.com> writes:
 > 
 > |> I can't believe there is no reliable way to get rid of that
 > |> pesky "$" gcc is adding to the symbol.  Oh well...
 > 
 > Use %c0.  *Note Output Templates and Operand Substitution: (gcc)Output
 > Template.

Nice, see Keith?  There are no excuses :-)

Later,
David S. Miller
davem@redhat.com
