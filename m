Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264728AbTFQNqD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:46:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264729AbTFQNqD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:46:03 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:26635 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S264728AbTFQNp6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:45:58 -0400
Subject: Re: Linux 2.4.21 working OK compiled with GCC 3.2.2
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Maciej =?ISO-8859-1?Q?G=F3rnicki?= <gutko@poczta.onet.pl>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <000b01c334c4$f2396d30$41010101@toshiba>
References: <20030617111718.GD64@DervishD>
	 <000b01c334c4$f2396d30$41010101@toshiba>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1055858387.588.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 17 Jun 2003 15:59:47 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-17 at 13:38, Maciej Górnicki wrote:
> I had even no problems compiling 2.4.21-ac1 with gcc3.3 :)

gcc 3.2.2 has some nasty bugs... At least, I have been smashing my head
against a wall for a long time, until I discovered that all my OOPses
and crashes with the ymfpci driver were caused by gcc 3.2.2.

