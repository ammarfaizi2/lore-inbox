Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266948AbSL3MtQ>; Mon, 30 Dec 2002 07:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266952AbSL3MtQ>; Mon, 30 Dec 2002 07:49:16 -0500
Received: from home.wiggy.net ([213.84.101.140]:1754 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id <S266948AbSL3MtP>;
	Mon, 30 Dec 2002 07:49:15 -0500
Date: Mon, 30 Dec 2002 13:57:38 +0100
From: Wichert Akkerman <wichert@wiggy.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Indention - why spaces?
Message-ID: <20021230125738.GK10971@wiggy.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20021230122857.GG10971@wiggy.net> <200212301249.gBUCnXrV001099@darkstar.example.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212301249.gBUCnXrV001099@darkstar.example.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously John Bradford wrote:
> In my opinion, indentation in any form is irritating.

So set your tabwidth/shiftwidth/whatever to 0 (or 1, at least vim
does not seem to allow you to set a zero shiftwidth).

> I find a left hand margin that jumps around, and in deeply nested
> loops effectively makes a 132 column terminal in to an 80 column
> terminal, completely pointless.

Well, I disagree. But I agree that the amount of indenting used is
a highly personal thing, and I find forcing a set limit by demanding
people use spaces a bad practice. But I don't do any kernel work,
so my opinion is probably of little value here.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>           http://www.wiggy.net/
A random hacker
