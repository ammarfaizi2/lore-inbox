Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131851AbQLMRr5>; Wed, 13 Dec 2000 12:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131914AbQLMRrr>; Wed, 13 Dec 2000 12:47:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:12928 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S131851AbQLMRr3>;
	Wed, 13 Dec 2000 12:47:29 -0500
Date: Wed, 13 Dec 2000 09:01:03 -0800
Message-Id: <200012131701.JAA03695@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: fribes@capgemini.fr
CC: ak@suse.de, linux-kernel@vger.kernel.org
In-Reply-To: <3A37AE70.B5F76D63@capgemini.fr> (message from Fabien Ribes on
	Wed, 13 Dec 2000 18:14:24 +0100)
Subject: Re: Networking: RFC1122 and 1123 status for kernel 2.4
In-Reply-To: <3A30F463.2EE04F4E@capgemini.fr> <200012081454.GAA02632@pizda.ninka.net> <20001208163154.A20038@gruyere.muc.suse.de> <200012081528.HAA02778@pizda.ninka.net> <20001208165855.A20706@gruyere.muc.suse.de> <200012112206.OAA00936@pizda.ninka.net> <3A37AE70.B5F76D63@capgemini.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Wed, 13 Dec 2000 18:14:24 +0100
   From: Fabien Ribes <fribes@capgemini.fr>

   I may get some time to work on this topic, but what do you mean by kill
   it ?

It means removing all of the "RFC1122 Status" comments from net/ipv4/*.c

   Is it the removal of RFC 1122 evaluation in modules' headers ? By
   the way, is RFC 1122 still accurate ?

It should be unless some later RFC specifies something which
supercedes a statement made in RFC1122, I believe there are not
many such cases if any.

Later,
David S. Miller
davem@redhat.com
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
