Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274362AbRJQDEb>; Tue, 16 Oct 2001 23:04:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274434AbRJQDEM>; Tue, 16 Oct 2001 23:04:12 -0400
Received: from pizda.ninka.net ([216.101.162.242]:58761 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S274362AbRJQDEG>;
	Tue, 16 Oct 2001 23:04:06 -0400
Date: Tue, 16 Oct 2001 20:02:21 -0700 (PDT)
Message-Id: <20011016.200221.30185716.davem@redhat.com>
To: yumoto@jpn.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: New virtual ethernet driver submitting...
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200110170247.f9H2l7g23588@hpujffg8.jpn.hp.com>
In-Reply-To: <200110170247.f9H2l7g23588@hpujffg8.jpn.hp.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Katsuyuki Yumoto <yumoto@jpn.hp.com>
   Date: Wed, 17 Oct 2001 11:47:07 +0900
   
   I've already written new two drivers of virtual ethernet. These
   aggregate(bundle) plural physical or virtual ethernet devices to
   single.

How is this different to, or more beneficial than, what
drivers/net/bonding.c is doing?

Franks a lot,
David S. Miller
davem@redhat.com
