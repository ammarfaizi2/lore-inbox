Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286154AbRLTF6b>; Thu, 20 Dec 2001 00:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286153AbRLTF6P>; Thu, 20 Dec 2001 00:58:15 -0500
Received: from pizda.ninka.net ([216.101.162.242]:46723 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286148AbRLTF5z>;
	Thu, 20 Dec 2001 00:57:55 -0500
Date: Wed, 19 Dec 2001 21:57:30 -0800 (PST)
Message-Id: <20011219.215730.66180642.davem@redhat.com>
To: torvalds@transmeta.com
Cc: cs@zip.com.au, billh@tierra.ucsd.edu, bcrl@redhat.com,
        linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: aio
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112192136300.19214-100000@penguin.transmeta.com>
In-Reply-To: <20011219.185847.77651573.davem@redhat.com>
	<Pine.LNX.4.33.0112192136300.19214-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 19 Dec 2001 21:47:18 -0800 (PST)
   
   it could very well be rather useful for many things that use select
   loops right now.

Then let us agree to disagree. :-) I think it's potential advantages,
and how many things really "require it" for better performance, is
being blown out of proportion.
