Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267368AbUGNMaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267368AbUGNMaq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jul 2004 08:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267372AbUGNMap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jul 2004 08:30:45 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:24524 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S267368AbUGNMan (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jul 2004 08:30:43 -0400
Date: Wed, 14 Jul 2004 14:30:33 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jeff Chua <jeffchua@silk.corp.fedex.com>
Cc: Pavel Machek <pavel@ucw.cz>, netdev@oss.sgi.com,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: ipw2100 wireless driver
Message-ID: <20040714123033.GB18364@louise.pinerecords.com>
References: <20040714114135.GA25175@elf.ucw.cz> <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0407141947270.27995@boston.corp.fedex.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul-14 2004, Wed, 19:48 +0800
Jeff Chua <jeffchua@silk.corp.fedex.com> wrote:

> >I have few problems with that:
> >
> >* it will not compile with gcc-2.95. Attached patch fixes one problem
> >but more remain.
> 
> I've given up hope on that. Don't think it'll ever compile on 2.95. I'm 
> using ndiswrapper and it works nicely.

I'd rather fiddle around with gcc versions than risk stack overflows
from running Windows drivers in Linux kernel space.

-- 
Tomas Szepe <szepe@pinerecords.com>
