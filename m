Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284245AbRLTLgH>; Thu, 20 Dec 2001 06:36:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284322AbRLTLfr>; Thu, 20 Dec 2001 06:35:47 -0500
Received: from pizda.ninka.net ([216.101.162.242]:28806 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S284245AbRLTLfj>;
	Thu, 20 Dec 2001 06:35:39 -0500
Date: Thu, 20 Dec 2001 03:34:58 -0800 (PST)
Message-Id: <20011220.033458.79429530.davem@redhat.com>
To: riel@conectiva.com.br
Cc: torvalds@transmeta.com, bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
        davidel@xmailserver.org, linux-kernel@vger.kernel.org
Subject: Re: Scheduler ( was: Just a second ) ...
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33L.0112200928110.15741-100000@imladris.surriel.com>
In-Reply-To: <20011219.213956.26276011.davem@redhat.com>
	<Pine.LNX.4.33L.0112200928110.15741-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Thu, 20 Dec 2001 09:29:28 -0200 (BRST)

   On Wed, 19 Dec 2001, David S. Miller wrote:
   > Sending files over sockets are %99 of what most network servers are
   > actually doing today, it is much more than 0.1% :-)
   
   The same could be said for AIO, there are a _lot_ of
   server programs which are heavily overthreaded because
   of a lack of AIO...

If you read my most recent responses to Ingo's postings, you'll see
that I'm starting to completely agree with you :-)
