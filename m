Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282084AbRK1Hjw>; Wed, 28 Nov 2001 02:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282081AbRK1Hjm>; Wed, 28 Nov 2001 02:39:42 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44433 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S281815AbRK1Hj2>;
	Wed, 28 Nov 2001 02:39:28 -0500
Date: Tue, 27 Nov 2001 23:39:25 -0800 (PST)
Message-Id: <20011127.233925.66707993.davem@redhat.com>
To: greearb@candelatech.com
Cc: vlan@Scry.WANfear.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] VLAN 1.6 against 2.4.16
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3C0491DA.9040602@candelatech.com>
In-Reply-To: <3C0491DA.9040602@candelatech.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ben Greear <greearb@candelatech.com>
   Date: Wed, 28 Nov 2001 00:27:22 -0700

   +        struct vlan_group* nextgroup;
   + 
   for (grp = p802_1Q_vlan_list; (grp != NULL);) {

Your mail agent wraps lines, this patch isn't going to apply
for anyone.
