Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263204AbSJORsO>; Tue, 15 Oct 2002 13:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264707AbSJORrv>; Tue, 15 Oct 2002 13:47:51 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24998 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264690AbSJORqP>;
	Tue, 15 Oct 2002 13:46:15 -0400
Date: Tue, 15 Oct 2002 10:44:23 -0700 (PDT)
Message-Id: <20021015.104423.36363214.davem@redhat.com>
To: maxk@qualcomm.com
Cc: kuznet@ms2.inr.ac.ru, mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Rename _bh to _softirq
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
References: <Pine.LNX.4.44.0210142119300.26635-100000@localhost.localdomain>
	<200210150157.FAA13254@sex.inr.ac.ru>
	<5.1.0.14.2.20021015093146.05eb7738@mail1.qualcomm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Maksim (Max) Krasnyanskiy" <maxk@qualcomm.com>
   Date: Tue, 15 Oct 2002 09:34:02 -0700
   
   But primary interface should be changed IMO.

I totally disagree.

Keep _bh, it's cool.
