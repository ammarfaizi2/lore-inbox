Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263323AbSIPXGJ>; Mon, 16 Sep 2002 19:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263324AbSIPXGJ>; Mon, 16 Sep 2002 19:06:09 -0400
Received: from pizda.ninka.net ([216.101.162.242]:13544 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263323AbSIPXGI>;
	Mon, 16 Sep 2002 19:06:08 -0400
Date: Mon, 16 Sep 2002 16:02:10 -0700 (PDT)
Message-Id: <20020916.160210.70782700.davem@redhat.com>
To: jgarzik@mandrakesoft.com
Cc: dwmw2@infradead.org, linux-kernel@vger.kernel.org, todd-lkml@osogrande.com,
       hadi@cyberus.ca, tcw@tempest.prismnet.com, netdev@oss.sgi.com,
       pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D86645F.5030401@mandrakesoft.com>
References: <12116.1032216780@redhat.com>
	<12293.1032217399@redhat.com>
	<3D86645F.5030401@mandrakesoft.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jeff Garzik <jgarzik@mandrakesoft.com>
   Date: Mon, 16 Sep 2002 19:08:15 -0400
   
   I was rather disappointed when file->file sendfile was [purposefully?] 
   broken in 2.5.x...

What change made this happen?
