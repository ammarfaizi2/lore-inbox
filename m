Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264538AbRFOVxl>; Fri, 15 Jun 2001 17:53:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264539AbRFOVxf>; Fri, 15 Jun 2001 17:53:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:15234 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264538AbRFOVx1>;
	Fri, 15 Jun 2001 17:53:27 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15146.33742.299279.102372@pizda.ninka.net>
Date: Fri, 15 Jun 2001 14:53:18 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: tvlists@networx.com.br (Thiago Vinhas de Moraes),
        laughing@shared-source.org (Alan Cox), linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.5-ac14
In-Reply-To: <E15B0vv-000780-00@the-village.bc.nu>
In-Reply-To: <200106162255.SAA02119@olimpo.networx.com.br>
	<E15B0vv-000780-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > Because right now I dont consider the 2.4.6 page cache ext2 stuff safe
 > enough to merge. I'm letting someone else be the sucide squad.. so far it
 > looks like it is indeed fine but I want to wait and see more yet

If it means anything it has already withstanded a few
cerebus-->fsck_check-->cerebus rounds on machines here
in my lab.

Later,
David S. Miller
davem@redhat.com
