Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268911AbRHQCB5>; Thu, 16 Aug 2001 22:01:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269413AbRHQCBq>; Thu, 16 Aug 2001 22:01:46 -0400
Received: from cs.utexas.edu ([128.83.139.9]:6035 "EHLO cs.utexas.edu")
	by vger.kernel.org with ESMTP id <S268911AbRHQCB1>;
	Thu, 16 Aug 2001 22:01:27 -0400
Date: Thu, 16 Aug 2001 21:01:40 -0500 (CDT)
From: Kalpesh Shah <kalpesh@cs.utexas.edu>
To: <linux-kernel@vger.kernel.org>
Subject: Socket options
Message-ID: <Pine.GSO.4.33.0108162055050.24575-100000@cabaco.cs.utexas.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I would like to be CC'ed any answers/comments to my question.

are /proc/sys/net/ipv4/tcp_rmem and /proc/sys/net/ipv4/tcp_wmem the socket
Buffer (receive and send respectively) Sizes in the linux kernel.

If yes then how come when I try to set these buffer sizes by using the
SO_RCVBUFF and SO_SNDBUFF variables it automatically multiplies the values
by 2 ????

-kalpesh


