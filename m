Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317761AbSGVTtP>; Mon, 22 Jul 2002 15:49:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317766AbSGVTtP>; Mon, 22 Jul 2002 15:49:15 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:49648 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317761AbSGVTtO>; Mon, 22 Jul 2002 15:49:14 -0400
Subject: Re: Problems with AMD 768 IDE support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ernst Lehmann <lehmann@acheron.franken.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1027364446.26894.2.camel@hadley>
References: <1027364446.26894.2.camel@hadley>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 22 Jul 2002 22:05:07 +0100
Message-Id: <1027371907.31782.72.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-07-22 at 20:00, Ernst Lehmann wrote:
> Does anybody know where to find a patch for the IDE-Support to the plain
> 2.4.18 kernel,

Pending for 2.4.20

For -ac we are chasing some bugs in the Summit support. 
2.4.19-rc1-3 should you fine. The summit fix stuff is waiting until
either I or more likely the IBM guys looking at it figure out what
broke. Its important enough I've left it in broken for some boards until
found.

