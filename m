Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286159AbRLTGDl>; Thu, 20 Dec 2001 01:03:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286146AbRLTGDS>; Thu, 20 Dec 2001 01:03:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:54147 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S286149AbRLTGCU>;
	Thu, 20 Dec 2001 01:02:20 -0500
Date: Wed, 19 Dec 2001 22:01:51 -0800 (PST)
Message-Id: <20011219.220151.56814481.davem@redhat.com>
To: torvalds@transmeta.com
Cc: riel@conectiva.com.br, bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
        davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: Scheduler ( was: Just a second ) ...
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0112192155390.19321-100000@penguin.transmeta.com>
In-Reply-To: <20011219.213956.26276011.davem@redhat.com>
	<Pine.LNX.4.33.0112192155390.19321-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Wed, 19 Dec 2001 21:58:41 -0800 (PST)
   
   Well, that was true when the thing was written, but whether anybody _uses_
   it any more, I don't know. Tux gets the same effect on its own, and I
   don't know if Apache defaults to using sendfile or not.
   
Samba uses it by default, that I know for sure :-)
