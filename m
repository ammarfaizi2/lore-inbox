Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317578AbSHHOZ7>; Thu, 8 Aug 2002 10:25:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317579AbSHHOZ7>; Thu, 8 Aug 2002 10:25:59 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36322 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317578AbSHHOZ7> convert rfc822-to-8bit;
	Thu, 8 Aug 2002 10:25:59 -0400
Date: Thu, 08 Aug 2002 07:16:41 -0700 (PDT)
Message-Id: <20020808.071641.127864472.davem@redhat.com>
To: pasik@iki.fi
Cc: tux@sentinel.dk, linux-kernel@vger.kernel.org
Subject: Re: forcing the tg3 into full duplex
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0208081546290.23460-100000@edu.joroinen.fi>
References: <1028809316.1770.13.camel@frda-linux.staff.tdk.net>
	<Pine.LNX.4.33.0208081546290.23460-100000@edu.joroinen.fi>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pasi Kärkkäinen <pasik@iki.fi>
   Date: Thu, 8 Aug 2002 15:47:18 +0300 (EEST)
   
   On 8 Aug 2002, Frederik Dannemare wrote:
   
   > anybody knows how to do this?
   
   I think tigon3-driver supports ethtool. Try it.

That's right.
