Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932421AbWESQFU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbWESQFU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 May 2006 12:05:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932422AbWESQFT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 May 2006 12:05:19 -0400
Received: from smtp.osdl.org ([65.172.181.4]:19919 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932421AbWESQFS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 May 2006 12:05:18 -0400
Date: Fri, 19 May 2006 09:05:00 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: sepreece@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] list.h doc: change "counter" to "control"
Message-Id: <20060519090500.6a3958dd.akpm@osdl.org>
In-Reply-To: <20060519090236.ef9b5c81.rdunlap@xenotime.net>
References: <20060518105400.2aac9f44.rdunlap@xenotime.net>
	<7b69d1470605190837o44f2c0f5o4aa9faa421dfb3f7@mail.gmail.com>
	<20060519090236.ef9b5c81.rdunlap@xenotime.net>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> wrote:
>
> On Fri, 19 May 2006 10:37:28 -0500 Scott Preece wrote:
> 
>  > I agree that "counter" is wrong, but "control" is still a little
>  > vague. How about:
>  > "the &struct list_head that tracks iteration over the list" or
>  > "the &struct list_head that tracks current location in list."
> 
>  I considered "iterator" (but that's the macro itself I think),
>  "control", "variable", "pointer", and "position".
>  "current location" would be OK with me.

"cursor"
