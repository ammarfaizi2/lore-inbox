Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318891AbSHMAVn>; Mon, 12 Aug 2002 20:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318892AbSHMAVn>; Mon, 12 Aug 2002 20:21:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:61857 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318891AbSHMAVm>;
	Mon, 12 Aug 2002 20:21:42 -0400
Date: Mon, 12 Aug 2002 17:11:55 -0700 (PDT)
Message-Id: <20020812.171155.92747788.davem@redhat.com>
To: Olaf.Dabrunz@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: TCP/IP connection setup using ECN: interaction with firewall
 problems
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020813021944.A11951@santana.vm.dabrunz.de>
References: <20020813021944.A11951@santana.vm.dabrunz.de>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Olaf Dabrunz <Olaf.Dabrunz@gmx.de>
   Date: Tue, 13 Aug 2002 02:19:44 +0200
   
   AFAICS from the kernel ChangeLogs Linux versions 2.4.* and 2.5.* do not
   implement the interoperability features described above. Is that correct?
   Is someone working on a patch that implements these features?

We purposely do not implement the interoperability features because
they have known holes and also we totally disagree with them in
principle.
