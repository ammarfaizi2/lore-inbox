Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281469AbRKTXD3>; Tue, 20 Nov 2001 18:03:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281467AbRKTXDQ>; Tue, 20 Nov 2001 18:03:16 -0500
Received: from pizda.ninka.net ([216.101.162.242]:35468 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281468AbRKTXC7>;
	Tue, 20 Nov 2001 18:02:59 -0500
Date: Tue, 20 Nov 2001 15:02:55 -0800 (PST)
Message-Id: <20011120.150255.35516071.davem@redhat.com>
To: owl@volny.cz
Cc: linux-kernel@vger.kernel.org
Subject: Re: BUG Kernel NETLINK doesn't work
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <001301c17212$f44ab8c0$2da76cc0@desktop>
In-Reply-To: <001301c17212$f44ab8c0$2da76cc0@desktop>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You have to enable RTNETLINK too.
