Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbULZLbB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbULZLbB (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 06:31:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261636AbULZLbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 06:31:01 -0500
Received: from levante.wiggy.net ([195.85.225.139]:40401 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S261635AbULZLbA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 06:31:00 -0500
Date: Sun, 26 Dec 2004 12:30:59 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Ho ho ho - Linux v2.6.10
Message-ID: <20041226113059.GC10303@wiggy.net>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.58.0412241434110.17285@ppc970.osdl.org> <1103977161.22646.6.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1103977161.22646.6.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.10 broke resume for me: when I resume it immediately tries to
suspend the machine again but gets stuck after suspending USB.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
