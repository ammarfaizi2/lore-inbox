Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbTFOQ4z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jun 2003 12:56:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262403AbTFOQ4z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jun 2003 12:56:55 -0400
Received: from pizda.ninka.net ([216.101.162.242]:20167 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262400AbTFOQ4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jun 2003 12:56:43 -0400
Date: Sun, 15 Jun 2003 10:06:23 -0700 (PDT)
Message-Id: <20030615.100623.23022212.davem@redhat.com>
To: yoshfuji@linux-ipv6.org
Cc: James.Bottomley@SteelEye.com, acme@conectiva.com.br,
       linux-kernel@vger.kernel.org
Subject: Re: New struct sock_common breaks parisc 64 bit compiles with a
 misalignment
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030616.020920.110657425.yoshfuji@linux-ipv6.org>
References: <1055221067.11728.14.camel@mulgrave>
	<20030610.091217.112601441.davem@redhat.com>
	<20030616.020920.110657425.yoshfuji@linux-ipv6.org>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
   Date: Mon, 16 Jun 2003 02:09:20 +0900 (JST)

   Like this?
   
I did this in my tree yesterday.
But thank you.
