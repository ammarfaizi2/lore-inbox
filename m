Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261338AbVBNF2V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261338AbVBNF2V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 00:28:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVBNF2V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 00:28:21 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:6417 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S261338AbVBNF2R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 00:28:17 -0500
Date: Mon, 14 Feb 2005 06:28:12 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Josh Aas <josha@sgi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.8.1 CPU Scheduler Documentation
Message-ID: <20050214052812.GA31941@alpha.home.local>
References: <420FEF73.30908@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <420FEF73.30908@sgi.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Josh,

On Sun, Feb 13, 2005 at 06:23:15PM -0600, Josh Aas wrote:
> Hello,
> 
> I have written an introduction to the Linux 2.6.8.1 CPU scheduler 
> implementation. It should help people to understand what is going on in 
> the scheduler code faster than they would be able to by just reading 
> through the code. The paper can be downloaded in PDF or LyX form from 
> here:
> 
> http://josh.trancesoftware.com/linux/

This is quite an interesting documentation.

Howver, the pdf version shows a problem that most of us encountered when
distributing PDF documents written in latex : the fonts are blurred and
need to be zoomed in to be readable. This is because you used the default
latex fonts. You just have to switch to PS fonts and it will be fine. For
this, I often added one of the following lines in the latex headers :

  \usepackage{times}
or
  \usepackage{palatino}

I don't know how it must be translated into lyx, but you get the general idea.

Thanks anyway for this document which seems rather complete.

Regards,
Willy

