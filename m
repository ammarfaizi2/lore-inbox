Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267558AbTBLQCF>; Wed, 12 Feb 2003 11:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267578AbTBLQCF>; Wed, 12 Feb 2003 11:02:05 -0500
Received: from ip68-13-105-80.om.om.cox.net ([68.13.105.80]:22400 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S267558AbTBLQCD>; Wed, 12 Feb 2003 11:02:03 -0500
Date: Wed, 12 Feb 2003 10:11:32 -0600 (CST)
From: Thomas Molina <tmolina@cox.net>
X-X-Sender: tmolina@localhost.localdomain
To: James Simmons <jsimmons@infradead.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: problems with console configuration
In-Reply-To: <Pine.LNX.4.44.0302121556090.31435-100000@phoenix.infradead.org>
Message-ID: <Pine.LNX.4.44.0302121000590.9224-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Feb 2003, James Simmons wrote:

> The console system is layered on top of the input layer. Now all keyboards 
> are being ported over to one api. This is a plus :-)

All good stuff, but I occasionally have problems seeing the video display 
as an input device :)  It sometimes turns into an adventure syncing with 
the latest bk archive and wondering what I need to do to get console and 
keyboard.

This is in addition to not getting bootup messages past the Uncompressing 
Linux message.  The extreme weirdness is that when this happens, something 
happens to the ext3 journal and I get a boot failure next reboot.

