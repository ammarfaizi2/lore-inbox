Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937742AbWLFW1M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937742AbWLFW1M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 17:27:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937740AbWLFW1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 17:27:12 -0500
Received: from lns-bzn-50f-81-56-194-193.adsl.proxad.net ([81.56.194.193]:45811
	"EHLO philou.philou.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S937743AbWLFW1L (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 17:27:11 -0500
Date: Wed, 6 Dec 2006 20:59:47 +0100
From: Philippe =?ISO-8859-15?Q?Gramoull=E9?= <philippe@gramoulle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 2.6.19: OOPS upon boot (not always)
In-Reply-To: <20061205215224.c19436a1.akpm@osdl.org>
References: <20061205215224.c19436a1.akpm@osdl.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.18; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20061206222704.DA4AE21D1@philou.gramoulle.local>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello Andrew,

On Tue, 5 Dec 2006 21:52:24 -0800
Andrew Morton <akpm@osdl.org> wrote:

  | > Picture's here : http://philou.org/2.6.19/2.6.19.crash.at.boot.jpg  
  | 
  | Boy, that's one obscure oops trace.   Do they all look like that?
  | If not, please send some more.

Well, this only happened once, out of about 20 or 30 reboots,
so i can't really tell.

In my first mail, i said that i had another similar oops,upon boot in 2.6.18.2,
though code path looks different, so that may be a totally other issue.
(I compiled some modules into the kernel, when i switched to 2.6.19)

I found the picture i took at the time:

http://philou.org/2.6.18.2/2.6.18.2.crash.at.boot.jpg

Config's here:

http://philou.org/2.6.18.2/config

Thanks Andrew, for taking the time to have a look.

Philippe
