Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262994AbTC0PoX>; Thu, 27 Mar 2003 10:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262996AbTC0PoW>; Thu, 27 Mar 2003 10:44:22 -0500
Received: from pizda.ninka.net ([216.101.162.242]:34532 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262994AbTC0PoV>;
	Thu, 27 Mar 2003 10:44:21 -0500
Date: Thu, 27 Mar 2003 07:52:39 -0800 (PST)
Message-Id: <20030327.075239.22164039.davem@redhat.com>
To: jmorris@intercode.com.au
Cc: alan@lxorguk.ukuu.org.uk, davidel@xmailserver.org,
       linux-kernel@vger.kernel.org
Subject: Re: Obsolete messages ...
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Mutt.LNX.4.44.0303280245110.29968-100000@blackbird.intercode.com.au>
References: <20030327.065911.29350824.davem@redhat.com>
	<Mutt.LNX.4.44.0303280245110.29968-100000@blackbird.intercode.com.au>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: James Morris <jmorris@intercode.com.au>
   Date: Fri, 28 Mar 2003 02:51:18 +1100 (EST)

   On Thu, 27 Mar 2003, David S. Miller wrote:
   
   > Now, I'll all for netratelimit()'ing the networking ones.
   
   What about warning just once like the SOCK_PACKET one?
   
Ok, applied.
