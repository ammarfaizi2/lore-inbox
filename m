Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264673AbSKDNkI>; Mon, 4 Nov 2002 08:40:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264674AbSKDNkI>; Mon, 4 Nov 2002 08:40:08 -0500
Received: from pizda.ninka.net ([216.101.162.242]:21888 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264673AbSKDNkH>;
	Mon, 4 Nov 2002 08:40:07 -0500
Date: Mon, 04 Nov 2002 06:39:28 -0800 (PST)
Message-Id: <20021104.063928.71089343.davem@redhat.com>
To: benoit-lists@fb12.de
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: [PATCH] tcp hang solved
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021104141852.A31235@turing.fb12.de>
References: <20021104123824.A29797@turing.fb12.de>
	<20021104.055951.41634255.davem@redhat.com>
	<20021104141852.A31235@turing.fb12.de>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Sebastian Benoit <benoit-lists@fb12.de>
   Date: Mon, 4 Nov 2002 14:18:53 +0100
   
   I removed parts of 2.5.43-bk1 and that solved my problem, see attached mail
   below.

That's just a list of files, can you send me the actual precise patch
you reverted?

