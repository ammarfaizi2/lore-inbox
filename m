Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267456AbSKQEdl>; Sat, 16 Nov 2002 23:33:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267459AbSKQEdl>; Sat, 16 Nov 2002 23:33:41 -0500
Received: from tapu.f00f.org ([66.60.186.129]:52679 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S267456AbSKQEdk>;
	Sat, 16 Nov 2002 23:33:40 -0500
Date: Sat, 16 Nov 2002 20:40:39 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
Subject: Re: [PATCH] 2.5.47: strdup()
Message-ID: <20021117044039.GA1860@tapu.f00f.org>
References: <87d6p63ui2.fsf@goat.bogus.local> <20021117000806.GB443@tapu.f00f.org> <873cq1nfhk.fsf@goat.bogus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <873cq1nfhk.fsf@goat.bogus.local>
User-Agent: Mutt/1.4i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 17, 2002 at 02:37:27AM +0100, Olaf Dietsche wrote:

> So you like duplicate code? Well, to each his own.

Not at all.

I'm just not sure I like strdup being *easy* to use at it leads to
misuse.  Admittedly this is a very poor argument for not having it.


  --cw
