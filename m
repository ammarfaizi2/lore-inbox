Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRJJDvI>; Tue, 9 Oct 2001 23:51:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274530AbRJJDu6>; Tue, 9 Oct 2001 23:50:58 -0400
Received: from psuvax1.cse.psu.edu ([130.203.4.6]:36575 "HELO mail.cse.psu.edu")
	by vger.kernel.org with SMTP id <S273902AbRJJDur>;
	Tue, 9 Oct 2001 23:50:47 -0400
Date: Tue, 9 Oct 2001 23:51:17 -0400 (EDT)
From: Jianyong Zhang <jzhang@cse.psu.edu>
To: <linux-kernel@vger.kernel.org>
Subject: a problem about non-linear sk_buff
Message-ID: <Pine.SOL.4.33.0110092342190.24061-100000@frack.cse.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

  I'm a newcomer of this list.  I want to understand the tcp/ip stack's
implementaion, and hope that I can get your help.

  I find that that sk_buff can be fragmented, and it's called nonlinear.
What's the meaning of nonlinear?  And what are the meaning of sk_buff's
fields: skb->data_len and skb_shinfo(skb)?  I have no idea about them.
May you explain them?  Thank you.

Jianyong Zhang


