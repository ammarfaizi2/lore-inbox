Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265199AbRGJAgs>; Mon, 9 Jul 2001 20:36:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265205AbRGJAgi>; Mon, 9 Jul 2001 20:36:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:55936 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265199AbRGJAgb>;
	Mon, 9 Jul 2001 20:36:31 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15178.19978.589748.168689@pizda.ninka.net>
Date: Mon, 9 Jul 2001 17:36:26 -0700 (PDT)
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Cc: fabrizio.gennari@philips.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: dev_get_by_name without dev_put
In-Reply-To: <20010704110655.B897@conectiva.com.br>
In-Reply-To: <OF870A7F74.AB18863F-ONC1256A7F.004AB8A1@diamond.philips.com>
	<20010704110655.B897@conectiva.com.br>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Arnaldo Carvalho de Melo writes:
 > For pppoe (and one has to look at the set_item and see if delete_item is
 > needed).

Applied, sorry for taking so long.

Later,
David S. Miller
davem@redhat.com
