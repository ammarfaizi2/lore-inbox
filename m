Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262828AbSJOTn6>; Tue, 15 Oct 2002 15:43:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264657AbSJOTn6>; Tue, 15 Oct 2002 15:43:58 -0400
Received: from pizda.ninka.net ([216.101.162.242]:45223 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S262828AbSJOTn5>;
	Tue, 15 Oct 2002 15:43:57 -0400
Date: Tue, 15 Oct 2002 12:42:04 -0700 (PDT)
Message-Id: <20021015.124204.108190832.davem@redhat.com>
To: maxk@qualcomm.com
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rename _bh to _softirq
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
References: <5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
	<20021015.104423.36363214.davem@redhat.com>
	<5.1.0.14.2.20021015121958.01b4acd8@mail1.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
   Date: Tue, 15 Oct 2002 12:24:18 -0700

   We don't give names to a functions based on the coolness, do we ?
   ;-)

cli() was cool too.

Just because you don't see that a base handler really is an
alias for softirq these days, doesn't mean we should delete
it.
