Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314201AbSDQXgK>; Wed, 17 Apr 2002 19:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314204AbSDQXgJ>; Wed, 17 Apr 2002 19:36:09 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:520 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S314201AbSDQXgI>; Wed, 17 Apr 2002 19:36:08 -0400
Subject: Re: IDE/raid performance
To: dean-list-linux-kernel@arctic.org (dean gaudet)
Date: Thu, 18 Apr 2002 00:52:28 +0100 (BST)
Cc: bbn-linux-kernel@clansoft.dk (Baldur Norddahl), nick@snowman.net,
        mdresser_l@windsormachine.com (Mike Dresser),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0204171514350.2509-100000@twinlark.arctic.org> from "dean gaudet" at Apr 17, 2002 03:35:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16xzDw-0003PI-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> doing nice things like going into HALT states; so it's entirely likely
> that it's consuming a substantial amount of power.  the BIOS does not

halt makes little if any difference on the newer processors for a typical
setup
