Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319838AbSINBic>; Fri, 13 Sep 2002 21:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319844AbSINBic>; Fri, 13 Sep 2002 21:38:32 -0400
Received: from tomts11.bellnexxia.net ([209.226.175.55]:49338 "EHLO
	tomts11-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S319838AbSINBic>; Fri, 13 Sep 2002 21:38:32 -0400
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: Jens Axboe <axboe@suse.de>, Andre Hedrick <andre@linux-ide.org>
Subject: Re: 34-mm2 ide problems - unexpected interrupt
Date: Fri, 13 Sep 2002 21:42:23 -0400
User-Agent: KMail/1.4.3
Cc: linux-kernel@vger.kernel.org
References: <200209120838.44092.tomlins@cam.org> <200209121830.51285.tomlins@cam.org> <20020913060647.GH1847@suse.de>
In-Reply-To: <20020913060647.GH1847@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200209132142.23964.tomlins@cam.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

To check if the problem I am seeing is with the port to 2.5 I tried
2.4.20-pre5-ac4 and 2.4.20-pre5-ac6.  Both booted correctly.

Now to try 2.5.34+bk without Andrew's mm patch.  If that fails what 
debugging info would help solve the unexpected interrupt problem?

TIA,

Ed Tomlinson
