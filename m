Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267648AbSLSXyo>; Thu, 19 Dec 2002 18:54:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267651AbSLSXyo>; Thu, 19 Dec 2002 18:54:44 -0500
Received: from air-2.osdl.org ([65.172.181.6]:6537 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267648AbSLSXym>;
	Thu, 19 Dec 2002 18:54:42 -0500
Date: Thu, 19 Dec 2002 16:01:32 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Justin Pryzby <justinpryzby@users.sourceforge.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Bug? undefined reference to `input_event'
In-Reply-To: <20021219234705.GA11106@perseus.homeunix.net>
Message-ID: <Pine.LNX.4.33L2.0212191559460.30841-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Dec 2002, Justin Pryzby wrote:

| Is somebody keeping fixing, or at least keeping track of, these
| configuration errors?  I've seen a bunch of configuration problems, and
| the typical response doesn't include a patch (which is fine, as long as
| it ultimately gets fixed).  If something can't be configured as a module,
| then it shouldn't be possible to configure it as a module.

That's what the kernel bugzilla is for.

http://bugzilla.kernel.org
or
http://bugme.osdl.org

And some of us are trying to address the issues.

| I can write patches for these things if someone gives me pointers for
| how the 2.{4,5} kernel configuration stuff works.
|
| > Stuff deleted...

-- 
~Randy

