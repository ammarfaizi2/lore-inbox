Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270662AbTGURXg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 13:23:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270663AbTGURXf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 13:23:35 -0400
Received: from tomts13-srv.bellnexxia.net ([209.226.175.34]:23795 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S270662AbTGURXe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 13:23:34 -0400
Date: Mon, 21 Jul 2003 13:37:15 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: "Sam (Uli) Freed" <sam@freed.net>
cc: James Simmons <jsimmons@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6-test1 does locks up VGA and keyboard
In-Reply-To: <3F1C21C3.4000901@freed.net>
Message-ID: <Pine.LNX.4.53.0307211336340.3076@localhost.localdomain>
References: <Pine.LNX.4.44.0307211817060.10689-100000@phoenix.infradead.org>
 <3F1C21C3.4000901@freed.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Jul 2003, Sam (Uli) Freed wrote:

> Sorry, I did something like menuconfig using the old 2.4 and then make 
> bzImage etc. Here is the .config from the 2.6 dir, attached.

is there a reason that you configured your mouse and keyboard as
modules, rather than building them into the kernel?  might this
be a possible problem?

rday
