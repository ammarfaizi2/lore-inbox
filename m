Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316675AbSIAL1f>; Sun, 1 Sep 2002 07:27:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316683AbSIAL1f>; Sun, 1 Sep 2002 07:27:35 -0400
Received: from pizda.ninka.net ([216.101.162.242]:4546 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S316675AbSIAL1e>;
	Sun, 1 Sep 2002 07:27:34 -0400
Date: Sun, 01 Sep 2002 04:25:39 -0700 (PDT)
Message-Id: <20020901.042539.63049493.davem@redhat.com>
To: szepe@pinerecords.com
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] warnkill trivia 2/2
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020901112856.GL32122@louise.pinerecords.com>
References: <20020901105643.GH32122@louise.pinerecords.com>
	<20020901.035749.37156689.davem@redhat.com>
	<20020901112856.GL32122@louise.pinerecords.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Tomas Szepe <szepe@pinerecords.com>
   Date: Sun, 1 Sep 2002 13:28:56 +0200

   > I think you mean something like "atomic_t const * v" which means the
   > pointer is constant, not the value.
   
   Precisely.

BTW who even passes around const atomic_t's?  Ie. what
genrated the warning and made you even edit this to begin with?
