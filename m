Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317458AbSHCE6o>; Sat, 3 Aug 2002 00:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317466AbSHCE6o>; Sat, 3 Aug 2002 00:58:44 -0400
Received: from pizda.ninka.net ([216.101.162.242]:19883 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317458AbSHCE6o>;
	Sat, 3 Aug 2002 00:58:44 -0400
Date: Fri, 02 Aug 2002 21:50:08 -0700 (PDT)
Message-Id: <20020802.215008.38071049.davem@redhat.com>
To: austin@digitalroadkill.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Tigon3 support in 2.4.19-RC1 is odd.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <1028306594.8885.12.camel@UberGeek.coremetrics.com>
References: <1028306594.8885.12.camel@UberGeek.coremetrics.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Austin Gonyou <austin@digitalroadkill.net>
   Date: 02 Aug 2002 11:43:14 -0500

   The Tx Bytes and Rx Bytes counters won't seem to go beyond 4gb. Has that
   been fixed? TIA.

It will be fixed in 2.4.20, for now just treat it as a feature.
