Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289549AbSAJRIh>; Thu, 10 Jan 2002 12:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289551AbSAJRI2>; Thu, 10 Jan 2002 12:08:28 -0500
Received: from pizda.ninka.net ([216.101.162.242]:29312 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S289549AbSAJRIS>;
	Thu, 10 Jan 2002 12:08:18 -0500
Date: Thu, 10 Jan 2002 09:07:24 -0800 (PST)
Message-Id: <20020110.090724.104031343.davem@redhat.com>
To: acme@conectiva.com.br
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] s/TCP_ESTABLISHED/PROTO_ESTABLISHED/g
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020110170626.GG1010@conectiva.com.br>
In-Reply-To: <20020110161629.GF1010@conectiva.com.br>
	<20020110.082141.74749837.davem@redhat.com>
	<20020110170626.GG1010@conectiva.com.br>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
   Date: Thu, 10 Jan 2002 15:06:26 -0200
   
   just to make sure I understood: "to the protocols" means creating
   IPX_ESTABLISHED, etc, or does it mean having the protocols include tcp.h?

Include tcp.h
