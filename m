Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318265AbSH1Aar>; Tue, 27 Aug 2002 20:30:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318302AbSH1Aaq>; Tue, 27 Aug 2002 20:30:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:25491 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318265AbSH1Aaq>;
	Tue, 27 Aug 2002 20:30:46 -0400
Date: Tue, 27 Aug 2002 17:29:24 -0700 (PDT)
Message-Id: <20020827.172924.107290535.davem@redhat.com>
To: s.biggs@softier.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in kernel code?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D6BB7CA.26619.363BFC@localhost>
References: <3D6BB5C3.16057.2E515C@localhost>
	<20020827.172304.22017977.davem@redhat.com>
	<3D6BB7CA.26619.363BFC@localhost>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Stephen C. Biggs" <s.biggs@softier.com>
   Date: Tue, 27 Aug 2002 17:32:58 -0700
   
   This is a "do while" loop so the first test is always done
   
No, a "do while" loop always executes the first iteration.
What version of the C language do you think we are using?
