Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262491AbTIELzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 07:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262496AbTIELzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 07:55:32 -0400
Received: from dns.toxicfilms.tv ([150.254.37.24]:56785 "EHLO
	dns.toxicfilms.tv") by vger.kernel.org with ESMTP id S262491AbTIELzb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 07:55:31 -0400
Date: Fri, 5 Sep 2003 13:55:29 +0200 (CEST)
From: Maciej Soltysiak <solt@dns.toxicfilms.tv>
To: Jan Ischebeck <mail@jan-ischebeck.de>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: 2.6.0-test4-mm6
In-Reply-To: <1062758896.2085.19.camel@JHome.uni-bonn.de>
Message-ID: <Pine.LNX.4.51.0309051337130.8675@dns.toxicfilms.tv>
References: <1062758896.2085.19.camel@JHome.uni-bonn.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 2. X11R6 won't start anymore, it fails with a strange
> Fatal server error:
> xf86OpenConsole: VT_GETMODE failed
> I can't find a reason for that in the changelog.
Well, I can't start X because I am using nvidia drivers + www.minion.de
patches, and some specs seem to have changed again.
kernel: nvidia: Unknown symbol kdev_val

If the kdev_t.h changes are going to stay, I will have to wait for
Christian Zander's updates to the nvidia 2.6-patch.

Regards,
Maciej
