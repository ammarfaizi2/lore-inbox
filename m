Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261605AbUGLSwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261605AbUGLSwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 14:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261610AbUGLSwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 14:52:47 -0400
Received: from mail1.fw-sj.sony.com ([160.33.82.68]:60041 "EHLO
	mail1.fw-sj.sony.com") by vger.kernel.org with ESMTP
	id S261605AbUGLSwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 14:52:45 -0400
Message-ID: <40F2DDFC.8010501@am.sony.com>
Date: Mon, 12 Jul 2004 11:52:44 -0700
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adam Kropelin <akropel1@rochester.rr.com>
CC: Andrew Morton <akpm@osdl.org>, Geert Uytterhoeven <geert@linux-m68k.org>,
       dtor_core@ameritech.net, karim@opersys.com,
       linux-kernel@vger.kernel.org, celinux-dev@tree.celinuxforum.org,
       tpoynor@mvista.com
Subject: Re: [PATCH] preset loops_per_jiffy for faster booting
References: <40EEF10F.1030404@am.sony.com> <200407102351.05059.dtor_core@ameritech.net> <40F0C8E8.2060908@opersys.com> <200407110019.14558.dtor_core@ameritech.net> <20040710222702.3718842e.akpm@osdl.org> <Pine.GSO.4.58.0407110945010.3013@waterleaf.sonytel.be> <20040711005156.1d6558dd.akpm@osdl.org> <20040711094128.A27649@mail.kroptech.com>
In-Reply-To: <20040711094128.A27649@mail.kroptech.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adam Kropelin wrote:
> Here's a patch. It places the relevant information on the same line as
> bogomips and does so without encouraging anyone to fiddle with
> loops_per_jiffy and screw up their kernel. 

The patch is missing the Kconfig piece.  Is the wording the
same as from your earlier patch?

=============================
Tim Bird
Architecture Group Co-Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
E-mail: tim.bird@am.sony.com
=============================
