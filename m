Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317900AbSGWByS>; Mon, 22 Jul 2002 21:54:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317907AbSGWByS>; Mon, 22 Jul 2002 21:54:18 -0400
Received: from pizda.ninka.net ([216.101.162.242]:37289 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317900AbSGWByQ>;
	Mon, 22 Jul 2002 21:54:16 -0400
Date: Mon, 22 Jul 2002 18:46:46 -0700 (PDT)
Message-Id: <20020722.184646.98053676.davem@redhat.com>
To: zwane@linuxpower.ca
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [2.5.27] Oops in tcp_v6_get_port
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0207221324530.32636-100000@linux-box.realnet.co.sz>
References: <Pine.LNX.4.44.0207221324530.32636-100000@linux-box.realnet.co.sz>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a fix pending, I tried to send Linus networking updates
but something prevented them from being installed it seems.  I'm
trying to work this out but Arnaldo did fix this and I do have
this in my 2.5.x net tree.
