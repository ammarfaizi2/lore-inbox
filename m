Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271503AbTGQRen (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 13:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271507AbTGQRen
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 13:34:43 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:45831 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S271503AbTGQRd5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 13:33:57 -0400
Date: Thu, 17 Jul 2003 18:48:51 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Gorik Van Steenberge <gvs@cia.zemos.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: cursor dissapears after setfont
In-Reply-To: <Pine.LNX.4.50L0.0307170849440.30014-100000@cia.zemos.net>
Message-ID: <Pine.LNX.4.44.0307171848270.10255-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I recently compiled 2.6.0-test1 and noticed that I didn't have a cursor on
> any tty but tty1. After testing some things I found out that the cursors
> dissapear after "setfont -v default8x9.psfu.gz". Also, the cursor does not
> dissapear on the tty that called setconfig. I also had this problem in
> 2.5.70. AFAIK I'm using the latest kbd.
> 
> I am not sure what info I should supply that would be relevant to this
> issue.
 
What is your configuration so I can replicate this problem?

