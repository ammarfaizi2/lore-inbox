Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313571AbSG2Isc>; Mon, 29 Jul 2002 04:48:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313711AbSG2Isc>; Mon, 29 Jul 2002 04:48:32 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24805 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313571AbSG2Isb>;
	Mon, 29 Jul 2002 04:48:31 -0400
Date: Mon, 29 Jul 2002 01:40:16 -0700 (PDT)
Message-Id: <20020729.014016.106964200.davem@redhat.com>
To: riel@conectiva.com.br
Cc: phillips@arcor.de, akpm@zip.com.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/13] misc fixes
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.44L.0207290544180.3086-100000@imladris.surriel.com>
References: <E17Z4v0-0002io-00@starship>
	<Pine.LNX.4.44L.0207290544180.3086-100000@imladris.surriel.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rik van Riel <riel@conectiva.com.br>
   Date: Mon, 29 Jul 2002 05:44:45 -0300 (BRT)
   
   Are you sure bash is using fork and not vfork ?

GNU Bash uses fork, GNU Make uses vfork :-)
