Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318125AbSFTGKX>; Thu, 20 Jun 2002 02:10:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318126AbSFTGKW>; Thu, 20 Jun 2002 02:10:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:51891 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318125AbSFTGKW>;
	Thu, 20 Jun 2002 02:10:22 -0400
Date: Wed, 19 Jun 2002 23:04:54 -0700 (PDT)
Message-Id: <20020619.230454.111974636.davem@redhat.com>
To: andrea@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre10aa3
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020620055933.GA1308@dualathlon.random>
References: <20020620055933.GA1308@dualathlon.random>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andrea Arcangeli <andrea@suse.de>
   Date: Thu, 20 Jun 2002 07:59:33 +0200

   Also not yet sure if DaveM is ok with the removal of
   prepare_to_switch, his last comment on that is negative as far I
   could see.

Ingo's stuff is perfectly fine, it was a brain fart
wrt. prepare_to_switch.
