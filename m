Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270851AbRHNVqn>; Tue, 14 Aug 2001 17:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270874AbRHNVqd>; Tue, 14 Aug 2001 17:46:33 -0400
Received: from pizda.ninka.net ([216.101.162.242]:1156 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S270851AbRHNVqR>;
	Tue, 14 Aug 2001 17:46:17 -0400
Date: Tue, 14 Aug 2001 14:43:47 -0700 (PDT)
Message-Id: <20010814.144347.95061445.davem@redhat.com>
To: thockin@sun.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: RFC: poll change
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3B799358.38EF3B72@sun.com>
In-Reply-To: <3B799358.38EF3B72@sun.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Hockin <thockin@sun.com>
   Date: Tue, 14 Aug 2001 14:08:40 -0700

   poll() currently does not allow you to pass more fd's than you have open. 

Tim, please check the latest sources, this has been fixed
in 2.4.x for several months.

Later,
David S. Miller
davem@redhat.com
