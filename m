Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265174AbTA1LjW>; Tue, 28 Jan 2003 06:39:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265177AbTA1LjW>; Tue, 28 Jan 2003 06:39:22 -0500
Received: from home.wiggy.net ([213.84.101.140]:19387 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S265174AbTA1LjW>;
	Tue, 28 Jan 2003 06:39:22 -0500
Date: Tue, 28 Jan 2003 12:48:40 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Bootscreen
Message-ID: <20030128114840.GV4868@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0301281113480.20283-100000@schubert.rdns.com> <200301281144.h0SBi0ld000233@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301281144.h0SBi0ld000233@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously John Bradford wrote:
> There are applications where it is not appropriate to have it, though,
> what if you were using Linux in an embedded device such as a set top
> box?

Kiosks and things like ATMs are another place where you do not want
a bootscreen. You do not want to possibly confuse customers with
stuff that they can't understand but show a nice friendly message saying
'the system is currently unavailable'.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
