Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262886AbVD2TGo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262886AbVD2TGo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 15:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262888AbVD2TGo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 15:06:44 -0400
Received: from web60218.mail.yahoo.com ([209.73.178.106]:29027 "HELO
	web60218.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262886AbVD2TGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 15:06:42 -0400
Message-ID: <20050429190641.21045.qmail@web60218.mail.yahoo.com>
Date: Fri, 29 Apr 2005 15:06:41 -0400 (EDT)
From: john doe <catcowcrow@yahoo.ca>
Subject: Re: ATA port addresses
To: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Further to my original post I am using an Intel ICH4
IDE controller on an Intel D845EBG2 motherboard.  I
hope this clarifies a little.

Thanks again

> Its architecture and board dependent. Linux will let
> you issue IDE
> taskfile command blocks via ioctls so you can avoid
> poking the hardware
> (and poking the hardware will upset the ide
> driver..)

______________________________________________________________________ 
Post your free ad now! http://personals.yahoo.ca
