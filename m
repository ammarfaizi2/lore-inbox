Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318432AbSH1BLM>; Tue, 27 Aug 2002 21:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318447AbSH1BLM>; Tue, 27 Aug 2002 21:11:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:49555 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S318432AbSH1BLL>;
	Tue, 27 Aug 2002 21:11:11 -0400
Date: Tue, 27 Aug 2002 18:09:53 -0700 (PDT)
Message-Id: <20020827.180953.122061677.davem@redhat.com>
To: s.biggs@softier.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug in kernel code?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D6BC06A.15764.57ED97@localhost>
References: <3D6BB999.5183.3D4AB9@localhost>
	<20020827.174244.24647029.davem@redhat.com>
	<3D6BC06A.15764.57ED97@localhost>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Stephen C. Biggs" <s.biggs@softier.com>
   Date: Tue, 27 Aug 2002 18:09:46 -0700
   
   There need to be some sanity checks in this code: what if mempages is passed as some insanely huge 
   number, e.g.

And then your mail ends.... let us know when you've fixed
your email client, this isn't rocket science :-)
