Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262728AbSJLC2k>; Fri, 11 Oct 2002 22:28:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262735AbSJLC2k>; Fri, 11 Oct 2002 22:28:40 -0400
Received: from pizda.ninka.net ([216.101.162.242]:54912 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262728AbSJLC2k>;
	Fri, 11 Oct 2002 22:28:40 -0400
Date: Fri, 11 Oct 2002 19:27:50 -0700 (PDT)
Message-Id: <20021011.192750.85684324.davem@redhat.com>
To: sandy@storm.ca
Cc: mk@linux-ipv6.org, linux-kernel@vger.kernel.org, design@lists.freeswan.org,
       usagi@linux-ipv6.org
Subject: Re: [Design] [PATCH] USAGI IPsec
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DA857AB.2010504@storm.ca>
References: <m3k7kpjt7c.wl@karaba.org>
	<3DA857AB.2010504@storm.ca>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sandy Harris <sandy@storm.ca>
   Date: Sat, 12 Oct 2002 10:11:07 -0700

   Please remove DES as it is insecure. For discussion, see:
   http://www.freeswan.org/freeswan_trees/freeswan-1.98b/doc/politics.html#desnotsecure

It's fine for testing purposes, leave it in.
