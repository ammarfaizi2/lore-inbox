Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282493AbRKZUgB>; Mon, 26 Nov 2001 15:36:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282491AbRKZUfx>; Mon, 26 Nov 2001 15:35:53 -0500
Received: from pizda.ninka.net ([216.101.162.242]:43904 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S282482AbRKZUfl>;
	Mon, 26 Nov 2001 15:35:41 -0500
Date: Mon, 26 Nov 2001 12:35:34 -0800 (PST)
Message-Id: <20011126.123534.48805566.davem@redhat.com>
To: jack@ucw.cz
Cc: marcelo@atrey.karlin.mff.cuni.cz, linux-net@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: Compile fix in network
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011126210926.B25797@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011126210926.B25797@atrey.karlin.mff.cuni.cz>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Jan Kara <jack@ucw.cz>
   Date: Mon, 26 Nov 2001 21:09:26 +0100

     I've found out that it's impossible to compile kernel without
   networking support (problem appeared in 2.4.15). Patch which
   fixes problem (just remove some includes which aren't really
   needed) is attached.

A fix for this is pending in my queue to Marcelo.
Please be patient, 2.4.17 will surely have this fixed :)
