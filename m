Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265966AbTGDKW6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jul 2003 06:22:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265972AbTGDKW6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jul 2003 06:22:58 -0400
Received: from home.wiggy.net ([213.84.101.140]:58499 "EHLO
	tornado.home.wiggy.net") by vger.kernel.org with ESMTP
	id S265966AbTGDKW5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jul 2003 06:22:57 -0400
Date: Fri, 4 Jul 2003 12:37:25 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.21 and 2.5.74 freeze on cardmgr start
Message-ID: <20030704103725.GA2306@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030704090329.GA1975@wiggy.net> <20030704102018.A4374@flint.arm.linux.org.uk> <20030704093732.GA2159@wiggy.net> <20030704113156.E4374@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030704113156.E4374@flint.arm.linux.org.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Russell King wrote:
> Ok, after discussing the problem with Arjan, can you try adding back
> the 0x804 to 0x8ff io port range?

That reintroduces the freeze again.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>      It is simple to make things.
http://www.wiggy.net/                     It is hard to make things simple.

