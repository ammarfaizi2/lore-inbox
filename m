Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290313AbSAPA45>; Tue, 15 Jan 2002 19:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290308AbSAPA4l>; Tue, 15 Jan 2002 19:56:41 -0500
Received: from pizda.ninka.net ([216.101.162.242]:8873 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290310AbSAPAxq>;
	Tue, 15 Jan 2002 19:53:46 -0500
Date: Tue, 15 Jan 2002 16:52:07 -0800 (PST)
Message-Id: <20020115.165207.02810582.davem@redhat.com>
To: torvalds@transmeta.com
Cc: davidel@xmailserver.org, bcrl@redhat.com, weber@nyc.rr.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Re: 2.5.3-pre1 compile error
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <Pine.LNX.4.33.0201151641260.1213-100000@penguin.transmeta.com>
In-Reply-To: <Pine.LNX.4.40.0201151644530.960-100000@blue1.dev.mcafeelabs.com>
	<Pine.LNX.4.33.0201151641260.1213-100000@penguin.transmeta.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Linus Torvalds <torvalds@transmeta.com>
   Date: Tue, 15 Jan 2002 16:43:58 -0800 (PST)
   
   If it's not in the IDE driver, I'm at a loss.

That "#if 1" buisness in the new ide-dma.c code looks
really suspicious...
