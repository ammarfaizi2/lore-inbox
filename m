Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273783AbRJYUFs>; Thu, 25 Oct 2001 16:05:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRJYUFi>; Thu, 25 Oct 2001 16:05:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:32640 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S276285AbRJYUFV>;
	Thu, 25 Oct 2001 16:05:21 -0400
Date: Thu, 25 Oct 2001 12:56:46 -0700 (PDT)
Message-Id: <20011025.125646.59654205.davem@redhat.com>
To: thockin@sun.com
Cc: mgm@paktronix.com, david@blue-labs.org, cfriesen@nortelnetworks.com,
        kuznet@ms2.inr.ac.ru, ja@ssi.bg, linux-kernel@vger.kernel.org
Subject: Re: issue: deleting one IP alias deletes all
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BD86FA9.A992FE96@sun.com>
In-Reply-To: <Pine.LNX.4.31.0110251234430.32029-100000@netmonster.pakint.net>
	<3BD86FA9.A992FE96@sun.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tim Hockin <thockin@sun.com>
   Date: Thu, 25 Oct 2001 13:01:45 -0700
   
   > Again - if you do not like this behaviour do not use the primary/secondary
   > addressing scopes. Use /32.
   
   Why should user-land be forced to work around what is obviously (to the
   vast majority of people in this discussion) a mis-feature?

You have to understand how routing works to setup IP, we're deeply
sorry about that.

Franks a lot,
David S. Miller
davem@redhat.com
