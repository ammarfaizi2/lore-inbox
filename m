Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262331AbTJNL01 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Oct 2003 07:26:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262355AbTJNL01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Oct 2003 07:26:27 -0400
Received: from fw.osdl.org ([65.172.181.6]:4294 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262331AbTJNL00 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Oct 2003 07:26:26 -0400
Date: Tue, 14 Oct 2003 04:29:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Thomas Winischhofer <thomas@winischhofer.net>
Cc: linux-kernel@vger.kernel.org, jsimmons@infradead.org, olh@suse.de,
       sam@ravnborg.org
Subject: Re: gcc -msoft-float [Was: Linux 2.6.0-test7 - stability freeze]
Message-Id: <20031014042939.4a139a07.akpm@osdl.org>
In-Reply-To: <3F8BB43A.9050808@winischhofer.net>
References: <3F8BB43A.9050808@winischhofer.net>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Winischhofer <thomas@winischhofer.net> wrote:
>
> This is fixed in the latest version of sisfb I sent to James Simmons; 
>  one more reason to merge the fbdev stuff...

Well afaik nobody is sending anything.  I've had some 35,000 line fbdev
patch in -mm for six weeks but have not seen anything since.

What's up?
