Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263599AbUDFCfx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 22:35:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263601AbUDFCfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 22:35:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:48587 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263599AbUDFCfN convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 22:35:13 -0400
Date: Mon, 5 Apr 2004 19:28:44 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: Luis Miguel =?ISO-8859-1?Q?Garc=EDa?= <ktech@wanadoo.es>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BTTV] is anyone taking care of this drivers?
Message-Id: <20040405192844.32a574e8.rddunlap@osdl.org>
In-Reply-To: <4072040F.6000507@wanadoo.es>
References: <4072040F.6000507@wanadoo.es>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.8a (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 06 Apr 2004 03:12:47 +0200 Luis Miguel García <ktech@wanadoo.es> wrote:

| hello,
| 
| I have written several times to kraxel at bytesex dot com but I got no 
| reply.
| 
| I have data for a new bttv 878 based card that I think must be 
| introduced in the cards database info in order to make it work.
| 
| Who is the maintainer of that driver right now?
| 
| Thanks a lot!
| 
| P.S.: CC me if you can... I'm not subscribed.

The maintainer (Gerd == kraxel) posted a patch for bttv today (for 2.6.5).
See http://lkml.org/lkml/2004/4/5/83

--
~Randy
