Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269188AbRGaGNn>; Tue, 31 Jul 2001 02:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269189AbRGaGNd>; Tue, 31 Jul 2001 02:13:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19361 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S269186AbRGaGNW>;
	Tue, 31 Jul 2001 02:13:22 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15206.19567.477213.727922@pizda.ninka.net>
Date: Mon, 30 Jul 2001 23:13:03 -0700 (PDT)
To: Sridhar Samudrala <samudrala@us.ibm.com>
Cc: jamal <hadi@cyberus.ca>, diffserv-general@lists.sourceforge.net,
        kuznet@ms2.inr.ac.ru, alan@lxorguk.ukuu.org.uk,
        linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
        rusty@rustcorp.com.au, thiemo@sics.se,
        Renu Tewari <tewarir@us.ibm.com>, dmfreim@us.ibm.com
Subject: Re: [Linux Diffserv] Re: [PATCH] Inbound Connection Control mechanism:
 Prioritized Accept Queue
In-Reply-To: <Pine.LNX.4.21.0107301359350.23307-100000@w-sridhar2.des.sequent.com>
In-Reply-To: <Pine.GSO.4.30.0107301515090.7013-100000@shell.cyberus.ca>
	<Pine.LNX.4.21.0107301359350.23307-100000@w-sridhar2.des.sequent.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


Sridhar Samudrala writes:
 > oss.software.ibm.com is running linux 2.2.19. I guess linux should by
 > default ignore ECN bits if it is not enabled. Do you think this ECN problem 
 > has something to do with the server or some router on the way the server?

As Jamal and Jeff have mentioned, it's not a Linux problem.  Rather
it's the buggy firewall products IBM is using.

Later,
David S. Miller
davem@redhat.com
