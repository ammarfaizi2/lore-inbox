Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319170AbSHGSfI>; Wed, 7 Aug 2002 14:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319171AbSHGSfI>; Wed, 7 Aug 2002 14:35:08 -0400
Received: from zeus.kernel.org ([204.152.189.113]:34758 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S319170AbSHGSfI>;
	Wed, 7 Aug 2002 14:35:08 -0400
Date: Wed, 07 Aug 2002 11:24:24 -0700 (PDT)
Message-Id: <20020807.112424.60322440.davem@redhat.com>
To: willy@debian.org
Cc: rusty@rustcorp.com.au, george@mvista.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: softirq parameters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020807193504.I24631@parcelfarce.linux.theplanet.co.uk>
References: <20020807192314.H24631@parcelfarce.linux.theplanet.co.uk>
	<20020807.111843.15996855.davem@redhat.com>
	<20020807193504.I24631@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Wed, 7 Aug 2002 19:35:04 +0100
   
   Hrm, I didn't realise what the implementation of percpu was... does it
   work for modules?
   
Good question, I bet it doesn't based upon how I understand
it to work.

Rusty?

