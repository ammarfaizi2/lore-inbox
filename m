Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129131AbRBZVD6>; Mon, 26 Feb 2001 16:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129129AbRBZVDt>; Mon, 26 Feb 2001 16:03:49 -0500
Received: from jalon.able.es ([212.97.163.2]:17805 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129104AbRBZVD1>;
	Mon, 26 Feb 2001 16:03:27 -0500
Date: Mon, 26 Feb 2001 22:03:06 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jakub@redhat.com, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        David <dllorens@lsi.uji.es>, linux-kernel@vger.kernel.org
Subject: Re: Posible bug in gcc
Message-ID: <20010226220306.A2403@werewolf.able.es>
In-Reply-To: <20010226123309.A16592@devserv.devel.redhat.com> <E14XRyY-0001gE-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <E14XRyY-0001gE-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Mon, Feb 26, 2001 at 19:02:19 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.26 Alan Cox wrote:
Also fails in gcc-2.96-0.38mdk (Mandrake Cooker):
rpm -q --changelog gcc
* Sat Feb 17 2001 Chmouel Boudjnah <chmouel@mandrakesoft.com> 2.96-0.38mdk

- exit 0 if [ $1 = 0 ] if we are in %postun (to don't screwd up the
  alternatives).

* Thu Feb 15 2001 David BAUDENS <baudens@mandrakesoft.com> 2.96-0.37mdk

- Fix build on PPC :)

* Thu Feb 15 2001 Chmouel Boudjnah <chmouel@mandrakesoft.com> 2.96-0.36mdk

- Break build on PPC ;).
- Red Hat patches, Jakub Jelinek (rel74) 5 new patches :

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.2-ac4 #2 SMP Mon Feb 26 00:21:23 CET 2001 i686

