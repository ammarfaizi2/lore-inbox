Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262160AbSJNUfr>; Mon, 14 Oct 2002 16:35:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262164AbSJNUfr>; Mon, 14 Oct 2002 16:35:47 -0400
Received: from pizda.ninka.net ([216.101.162.242]:16029 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262160AbSJNUfg>;
	Mon, 14 Oct 2002 16:35:36 -0400
Date: Mon, 14 Oct 2002 13:33:37 -0700 (PDT)
Message-Id: <20021014.133337.45996640.davem@redhat.com>
To: root@chaos.analogic.com
Cc: genlogic@inrete.it, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.3.95.1021014162539.16867B-100000@chaos.analogic.com>
References: <3DAB1F00.667B82B5@inrete.it>
	<Pine.LNX.3.95.1021014162539.16867B-100000@chaos.analogic.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Richard B. Johnson" <root@chaos.analogic.com>
   Date: Mon, 14 Oct 2002 16:33:50 -0400 (EDT)
   
   This cannot be the reason for your problem. The name of a structure
   member has no connection whatsoever with the name of any function or
   definition.

try instead

#define current foo()
