Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318168AbSGQBDV>; Tue, 16 Jul 2002 21:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318169AbSGQBDU>; Tue, 16 Jul 2002 21:03:20 -0400
Received: from pizda.ninka.net ([216.101.162.242]:48089 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318168AbSGQBDT>;
	Tue, 16 Jul 2002 21:03:19 -0400
Date: Tue, 16 Jul 2002 17:56:48 -0700 (PDT)
Message-Id: <20020716.175648.101482617.davem@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: 2.5.x linux/input.h:KEY_{PLAY,FASTFORWARD}
From: "David S. Miller" <davem@redhat.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Why are they defined twice to two different values?
