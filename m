Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264639AbSKDKkF>; Mon, 4 Nov 2002 05:40:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264632AbSKDKkF>; Mon, 4 Nov 2002 05:40:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:30689 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261337AbSKDKkE>;
	Mon, 4 Nov 2002 05:40:04 -0500
Date: Mon, 04 Nov 2002 02:36:20 -0800 (PST)
Message-Id: <20021104.023620.20862097.davem@redhat.com>
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] tcp hang solved
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <UTC200211040027.gA40RQ103595.aeb@smtp.cwi.nl>
References: <UTC200211040027.gA40RQ103595.aeb@smtp.cwi.nl>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Andries.Brouwer@cwi.nl
   Date: Mon, 4 Nov 2002 01:27:26 +0100 (MET)
   
   So, the following patch should be appropriate.

Thanks for this fix, I will apply it.  I have no idea why I didn't
spot this while 'porting' this patch from 2.4.x to 2.5.x :)
