Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131233AbRC0QJD>; Tue, 27 Mar 2001 11:09:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131363AbRC0QIo>; Tue, 27 Mar 2001 11:08:44 -0500
Received: from maestro.symsys.com ([208.223.9.37]:59154 "EHLO
	maestro.symsys.com") by vger.kernel.org with ESMTP
	id <S131233AbRC0QIf>; Tue, 27 Mar 2001 11:08:35 -0500
Date: Tue, 27 Mar 2001 10:07:41 -0600 (CST)
From: Greg Ingram <ingram@symsys.com>
To: linux-kernel@vger.kernel.org
Subject: Config bug? In 2.2.19 CONFIG_RTL8139 depends on CONFIG_EXPERIMENTAL
In-Reply-To: <p05100801b6e661f7a5cc@[207.213.214.34]>
Message-ID: <Pine.LNX.4.21.0103271000490.21814-100000@maestro.symsys.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


In 2.2.19 CONFIG_RTL8139 depends on CONFIG_EXPERIMENTAL.  The RTL8139
driver is not labelled as experimental.  Is this an error?

- Greg


