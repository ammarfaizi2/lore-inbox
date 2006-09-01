Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWIAKWo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWIAKWo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 06:22:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWIAKWo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 06:22:44 -0400
Received: from 1wt.eu ([62.212.114.60]:53521 "EHLO 1wt.eu")
	by vger.kernel.org with ESMTP id S1751015AbWIAKWn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 06:22:43 -0400
Date: Fri, 1 Sep 2006 11:57:49 +0200
From: Willy Tarreau <w@1wt.eu>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       mtosatti@redhat.com
Subject: Re: Linux 2.4.34-pre2
Message-ID: <20060901095749.GB28771@1wt.eu>
References: <20060831201952.GA25445@hera.kernel.org> <Pine.LNX.4.62.0609011142490.20760@pademelon.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609011142490.20760@pademelon.sonytel.be>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2006 at 11:45:07AM +0200, Geert Uytterhoeven wrote:
> On Thu, 31 Aug 2006, Willy Tarreau wrote:
> > This is Linux 2.4.34-pre2. It fixes several security issues which are
> 
> Apparently the patch is now relative to 2.4.34-pre1, not 2.4.33, while previous
> 2.4.*-pre* patches were relative to the previous full release?

Oh, sorry, that was not expected at all, it's a but in my release script !!!
I've removed the wrong files and have updated the new one now. Please wait
a few minutes for the mirrors to be updated. I know it might leave some
mirrors with the old ones for some time, but it's better not to keep a
broken file there.

> This definitely breaks some scripts (incl. mine ;-(
> 
> Gr{oetje,eeting}s,
> 
> 						Geert

Thanks Geert for having notified me, and sorry again for the mess :-(
Willy

