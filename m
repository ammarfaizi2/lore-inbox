Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262996AbSJGMAI>; Mon, 7 Oct 2002 08:00:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262997AbSJGMAI>; Mon, 7 Oct 2002 08:00:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28312 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262996AbSJGMAB>;
	Mon, 7 Oct 2002 08:00:01 -0400
Date: Mon, 07 Oct 2002 04:58:44 -0700 (PDT)
Message-Id: <20021007.045844.12156576.davem@redhat.com>
To: hadi@cyberus.ca
Cc: greearb@candelatech.com, andre@pyxtechnologies.com,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: Update on e1000 troubles (over-heating!)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.GSO.4.30.0210070749430.1861-100000@shell.cyberus.ca>
References: <3DA103A2.1060901@candelatech.com>
	<Pine.GSO.4.30.0210070749430.1861-100000@shell.cyberus.ca>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: jamal <hadi@cyberus.ca>
   Date: Mon, 7 Oct 2002 07:53:26 -0400 (EDT)
   
   Does the problem happen with the tg3?

He gets hangs in one box, inoperable PCI config space accesses for the
cards in another box.
