Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264878AbSLHJka>; Sun, 8 Dec 2002 04:40:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265255AbSLHJka>; Sun, 8 Dec 2002 04:40:30 -0500
Received: from node-d-1ea6.a2000.nl ([62.195.30.166]:21742 "EHLO
	laptop.fenrus.com") by vger.kernel.org with ESMTP
	id <S264878AbSLHJka>; Sun, 8 Dec 2002 04:40:30 -0500
Subject: Re: 2.4.20 e100/e1000 drivers and mii-[tool,diag]
From: Arjan van de Ven <arjanv@redhat.com>
To: Byron Albert <balbert@jupitermedia.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3DF3104A.50907@jupitermedia.com>
References: <3DF3104A.50907@jupitermedia.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 08 Dec 2002 10:48:03 +0100
Message-Id: <1039340884.1483.0.camel@laptop.fenrus.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-12-08 at 10:26, Byron Albert wrote:
> The mii-tool program does not work with e100 and e1000 drivers that 
> comes with the 2.4.20 kernel. With out this how do you set the interface 
> speed when you comple these built into the kernel?

ethtool of course

