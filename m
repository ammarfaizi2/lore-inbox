Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265256AbSIWDPr>; Sun, 22 Sep 2002 23:15:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265258AbSIWDPq>; Sun, 22 Sep 2002 23:15:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32948 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S265256AbSIWDPq>;
	Sun, 22 Sep 2002 23:15:46 -0400
Date: Sun, 22 Sep 2002 20:11:02 -0700 (PDT)
Message-Id: <20020922.201102.66637415.davem@redhat.com>
To: vonbrand@inf.utfsm.cl
Cc: marcelo@plucky.distro.conectiva, linux-kernel@vger.kernel.org
Subject: Re: 2.4.20-pre7 (BK from today)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200209222347.g8MNloWP004456@pincoya.inf.utfsm.cl>
References: <200209222347.g8MNloWP004456@pincoya.inf.utfsm.cl>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Horst von Brand <vonbrand@inf.utfsm.cl>
   Date: Sun, 22 Sep 2002 19:47:49 -0400

   net/ipv4/netfilter/ip_conntrack_proto_tcp.c needs
   
    #include <linux/string.h>

Thanks I've made this fix to my sources.
