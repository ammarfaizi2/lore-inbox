Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUEPS1m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUEPS1m (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 May 2004 14:27:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbUEPS1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 May 2004 14:27:42 -0400
Received: from av13-1-sn4.m-sp.skanova.net ([81.228.10.104]:63463 "EHLO
	av13-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S264775AbUEPS1k convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 May 2004 14:27:40 -0400
X-Mailer: exmh version 2.6.3 04/02/2003 (gentoo 2.6.3) with nmh-1.1
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.6] Synaptics driver is 'jumpy' 
In-Reply-To: Message from aeriksson@fastmail.fm 
   of "Sun, 16 May 2004 19:55:38 +0200." <20040516175539.075544137@latitude.mynet.no-ip.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Sun, 16 May 2004 20:27:09 +0200
From: aeriksson@fastmail.fm
Message-Id: <20040516182709.BBBE34137@latitude.mynet.no-ip.org>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 

fwiw, I have the same observation moving from 2.6.5-mm4 -> 2.6.6 on a
gentoo machine... On the observations side, i can add that it not
only fails to smoothly follow the track it should, but it seems it's
back to its old bad behavior of randomly jumping to the top-right
corner of the screen... :-(


Oh, and this is on a Dell L400 with synaptics touchpad, but using the
external ps/2 port to a "normal" mouse... No USB involved...


