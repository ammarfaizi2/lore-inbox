Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318263AbSIBKXn>; Mon, 2 Sep 2002 06:23:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318265AbSIBKXn>; Mon, 2 Sep 2002 06:23:43 -0400
Received: from pizda.ninka.net ([216.101.162.242]:40906 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318263AbSIBKXm>;
	Mon, 2 Sep 2002 06:23:42 -0400
Date: Mon, 02 Sep 2002 03:21:40 -0700 (PDT)
Message-Id: <20020902.032140.73653952.davem@redhat.com>
To: phillips@arcor.de
Cc: wli@holomorphy.com, rml@tech9.net, rusty@rustcorp.com.au,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E17loOP-0004gZ-00@starship>
References: <E17loGE-0004gS-00@starship>
	<20020902.031123.04737167.davem@redhat.com>
	<E17loOP-0004gZ-00@starship>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Phillips <phillips@arcor.de>
   Date: Mon, 2 Sep 2002 12:25:13 +0200

   Great!  Now we can communicate.  (cdr from-location) is:
   
     a) a list
   
   or
   
     b) a list marker?

It is a lisp object.
