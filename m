Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261322AbSI3VAj>; Mon, 30 Sep 2002 17:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261323AbSI3VAj>; Mon, 30 Sep 2002 17:00:39 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47028 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261322AbSI3VAi>;
	Mon, 30 Sep 2002 17:00:38 -0400
Date: Mon, 30 Sep 2002 13:59:11 -0700 (PDT)
Message-Id: <20020930.135911.11242542.davem@redhat.com>
To: jochen@scram.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.3.39 LLC on Alpha broken?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209301956320.1163-100000@alpha.bocc.de>
References: <Pine.NEB.4.44.0209300934330.7633-100000@www2.scram.de>
	<Pine.LNX.4.44.0209301956320.1163-100000@alpha.bocc.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jochen Friedrich <jochen@scram.de>
   Date: Mon, 30 Sep 2002 19:58:43 +0200 (CEST)

   > I'll try to reboot the remaining mess and report how far it gets...
   
   It looks like LLC is the culprit for me:
   
Arnaldo fixed this recently, it is a LLC bug.
