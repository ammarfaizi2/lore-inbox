Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261732AbTAIHUH>; Thu, 9 Jan 2003 02:20:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261742AbTAIHUH>; Thu, 9 Jan 2003 02:20:07 -0500
Received: from fencepost.gnu.org ([199.232.76.164]:21153 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP
	id <S261732AbTAIHUF>; Thu, 9 Jan 2003 02:20:05 -0500
From: Richard Stallman <rms@gnu.org>
To: andre@linux-ide.org
CC: linux-kernel@vger.kernel.org
In-reply-to: <Pine.LNX.4.10.10301031425590.421-100000@master.linux-ide.org>
	(message from Andre Hedrick on Fri, 3 Jan 2003 15:01:51 -0800 (PST))
Subject: Re: Gauntlet Set NOW!
Reply-to: rms@gnu.org
References: <Pine.LNX.4.10.10301031425590.421-100000@master.linux-ide.org>
Message-Id: <E18WX7P-0001cV-00@fencepost.gnu.org>
Date: Thu, 09 Jan 2003 02:28:47 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure what your project is designed to do, so I don't have an
opinion about how it stands regarding the GPL.  However, I've talked
with our lawyer about one specific issue that you raised: that of
using simple material from header files.

Someone recently made the claim that including a header file always
makes a derivative work.

That's not the FSF's view.  Our view is that just using structure
definitions, typedefs, enumeration constants, macros with simple
bodies, etc., is NOT enough to make a derivative work.  It would take
a substantial amount of code (coming from inline functions or macros
with substantial bodies) to do that.

