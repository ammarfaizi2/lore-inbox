Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263089AbSIPVdZ>; Mon, 16 Sep 2002 17:33:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263099AbSIPVdZ>; Mon, 16 Sep 2002 17:33:25 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19431 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263089AbSIPVdY>;
	Mon, 16 Sep 2002 17:33:24 -0400
Date: Mon, 16 Sep 2002 14:29:31 -0700 (PDT)
Message-Id: <20020916.142931.126209536.davem@redhat.com>
To: linux-kernel@vger.kernel.org, todd-lkml@osogrande.com
Cc: hadi@cyberus.ca, tcw@tempest.prismnet.com, netdev@oss.sgi.com,
       pfeather@cs.unm.edu
Subject: Re: Early SPECWeb99 results on 2.5.33 with TSO on e1000
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44.0209161528140.13850-100000@gp.staff.osogrande.com>
References: <20020916.125211.82482173.davem@redhat.com>
	<Pine.LNX.4.44.0209161528140.13850-100000@gp.staff.osogrande.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: todd-lkml@osogrande.com
   Date: Mon, 16 Sep 2002 15:32:56 -0600 (MDT)
   
   new system calls into the networking code

The system calls would go into the VFS, sys_receivefile is not
networking specific in any way shape or form.

And to answer your question, if I had the time I'd work on it yes.

Right now the answer to "well do you have the time" is no, I am
working on something much more important wrt. Linux networking.  I've
hinted at what this is in previous postings, and if people can't
figure out what it is I'm not going to mention this explicitly :-)
