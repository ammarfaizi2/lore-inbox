Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264288AbRFPQeq>; Sat, 16 Jun 2001 12:34:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264321AbRFPQeg>; Sat, 16 Jun 2001 12:34:36 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39303 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264288AbRFPQeY>;
	Sat, 16 Jun 2001 12:34:24 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15147.35421.866268.67790@pizda.ninka.net>
Date: Sat, 16 Jun 2001 09:33:33 -0700 (PDT)
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <oupzob9q84y.fsf@pigdrop.muc.suse.de>
In-Reply-To: <200106162255.SAA02119@olimpo.networx.com.br.suse.lists.linux.kernel>
	<E15B0vv-000780-00@the-village.bc.nu.suse.lists.linux.kernel>
	<15146.33742.299279.102372@pizda.ninka.net.suse.lists.linux.kernel>
	<oupzob9q84y.fsf@pigdrop.muc.suse.de>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Andi Kleen writes:
 > ... it also seems to make ppc not boot anymore.

Which is odd since all my machines are big-endian too.

It might smell of a compiler bug...

Later,
David S. Miller
davem@redhat.com

