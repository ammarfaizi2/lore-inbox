Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273870AbRJIJ2Y>; Tue, 9 Oct 2001 05:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273877AbRJIJ2O>; Tue, 9 Oct 2001 05:28:14 -0400
Received: from pizda.ninka.net ([216.101.162.242]:62092 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S273870AbRJIJ2I>;
	Tue, 9 Oct 2001 05:28:08 -0400
Date: Tue, 09 Oct 2001 02:28:34 -0700 (PDT)
Message-Id: <20011009.022834.26534969.davem@redhat.com>
To: panto@intracom.gr
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] Standard way of generating assembler offsets
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3BC2A98C.A57EA360@intracom.gr>
In-Reply-To: <1002563771.21079.3.camel@keller>
	<3BC1F7D6.E84D617B@mvista.com>
	<3BC2A98C.A57EA360@intracom.gr>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I think your work is way over-engineered and that you really
need to look at the very simple method by which we do this
on sparc64.

Franks a lot,
David S. Miller
davem@redhat.com
