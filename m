Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262378AbTESKpS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 06:45:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262379AbTESKpS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 06:45:18 -0400
Received: from [213.171.53.133] ([213.171.53.133]:39689 "EHLO gulipin.miee.ru")
	by vger.kernel.org with ESMTP id S262378AbTESKpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 06:45:17 -0400
Date: Mon, 19 May 2003 13:59:48 +0400
From: Samium Gromoff <deepfire@ibe.miee.ru>
To: linux-kernel@vger.kernel.org
Subject: Re: recursive spinlock. Shoot.
Message-Id: <20030519135948.0f0be20f.deepfire@ibe.miee.ru>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i386-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Not that my opinion matters much, but my feeling is that such measures
are very much of the bandaid taste, the ones which in the end piled one on another 
end up obscuring the very problems in the code.

	In short, it`ll probably make _filling_in_ the code easier, but the effect is
that it will shift the balance towards crap accumulation.

	To me, that is the damage of the kind which is very hard to undo.

regards, Samium Gromoff
