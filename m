Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266540AbTCEWs0>; Wed, 5 Mar 2003 17:48:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266716AbTCEWs0>; Wed, 5 Mar 2003 17:48:26 -0500
Received: from pizda.ninka.net ([216.101.162.242]:20413 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266540AbTCEWsZ>;
	Wed, 5 Mar 2003 17:48:25 -0500
Date: Wed, 05 Mar 2003 14:39:51 -0800 (PST)
Message-Id: <20030305.143951.118510613.davem@redhat.com>
To: bunk@fs.tum.de
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: Chaotic structure of the net headers?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030305225441.GO20423@fs.tum.de>
References: <20030305225441.GO20423@fs.tum.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Adrian Bunk <bunk@fs.tum.de>
   Date: Wed, 5 Mar 2003 23:54:41 +0100
   
   Two different #define's for the same thing doesn't sound like a good 
   idea?

Required by the ipv6 advanced sockets API I do believe.

