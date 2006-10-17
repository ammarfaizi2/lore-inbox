Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750701AbWJQV1F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750701AbWJQV1F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 17:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750709AbWJQV1E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 17:27:04 -0400
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:63114 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1750699AbWJQV1D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 17:27:03 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:Subject:Date:To:Cc:Bcc:Message-Id:Content-Type:Content-Transfer-Encoding:User-Agent;
  b=dYQfcofE3tYbrNZxhupnCHoxBpDIU1hMa2rGd7o/k0jffCQo2B6+2aHfD06gc5q1j28kxRDvfxw9Ydu3qv2q0pMKc6TgbPkSuPGBsRl+FPaMqOMrCHZtTtxUiF1zYv9o2okcmdHmxW4owqKcKRF3IPh10pMmgqsIDYjnzSwUWmM=  ;
From: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Subject: [PATCH 00/10] Various UML patches for 2.6.19
Date: Tue, 17 Oct 2006 23:19:43 +0200
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Message-Id: <20061017211943.26445.75719.stgit@americanbeauty.home.lan>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some other tested and little UML fixes for 2.6.19 (not all ones are oneliner,
but those ones are tested).
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade
http://www.user-mode-linux.org/~blaisorblade
Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
