Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263370AbTDCMby>; Thu, 3 Apr 2003 07:31:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263372AbTDCMby>; Thu, 3 Apr 2003 07:31:54 -0500
Received: from pizda.ninka.net ([216.101.162.242]:47509 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263370AbTDCMbx>;
	Thu, 3 Apr 2003 07:31:53 -0500
Date: Thu, 03 Apr 2003 04:38:33 -0800 (PST)
Message-Id: <20030403.043833.57345754.davem@redhat.com>
To: daniel.ritz@gmx.ch
Cc: linux-kernel@vger.kernel.org, szazol@e98.hu
Subject: Re: [PATCH 2.5] fix /proc/net/route missing the default route
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <200304011917.07544.daniel.ritz@gmx.ch>
References: <200304011917.07544.daniel.ritz@gmx.ch>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Daniel Ritz <daniel.ritz@gmx.ch>
   Date: Tue, 1 Apr 2003 19:17:07 +0200

   this one fixes /proc/net/route missing the default route for me.
   [see http://bugme.osdl.org/show_bug.cgi?id=528 ]
   against 2.5.66-bk. please apply if it's correct.

I've applied your patch, thanks Daniel.
