Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263214AbTDLJ2E (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 05:28:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263215AbTDLJ2E (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 05:28:04 -0400
Received: from home.wiggy.net ([213.84.101.140]:27559 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S263214AbTDLJ2D (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 05:28:03 -0400
Date: Sat, 12 Apr 2003 11:39:47 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [FIX] Re: 2.5.66 new fbcon oops while loading X
Message-ID: <20030412093947.GK21244@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <9CF13F6538@vcnet.vc.cvut.cz> <BKEGKPICNAKILKJKMHCAIEFBCGAA.Riley@Williams.Name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BKEGKPICNAKILKJKMHCAIEFBCGAA.Riley@Williams.Name>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Riley Williams wrote:
> Surely the correct fix is to have the updated MAKEDEV do something
> along the lines of...

That's fine for new installs, but people never run MAKEDEV when
upgrading their kernel.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
