Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277821AbRJRQuc>; Thu, 18 Oct 2001 12:50:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277825AbRJRQuW>; Thu, 18 Oct 2001 12:50:22 -0400
Received: from pizda.ninka.net ([216.101.162.242]:44675 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S277821AbRJRQuM>;
	Thu, 18 Oct 2001 12:50:12 -0400
Date: Thu, 18 Oct 2001 09:49:56 -0700 (PDT)
Message-Id: <20011018.094956.107683652.davem@redhat.com>
To: sim@netnation.com
Cc: andi@firstfloor.org, kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org
Subject: Re: Awfully slow /proc/net/tcp, netstat, in.identd in 2.4 (updated)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011018094222.A31919@netnation.com>
In-Reply-To: <20011018094222.A31919@netnation.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Let me guess, the machine exhibiting the problem has the largest
amount of physical memory?

Franks a lot,
David S. Miller
davem@redhat.com
