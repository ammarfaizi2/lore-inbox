Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261570AbTCaK5t>; Mon, 31 Mar 2003 05:57:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261572AbTCaK5t>; Mon, 31 Mar 2003 05:57:49 -0500
Received: from [81.2.110.254] ([81.2.110.254]:9208 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S261570AbTCaK5t>;
	Mon, 31 Mar 2003 05:57:49 -0500
Subject: Re: hdparm and removable IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Ron House <house@usq.edu.au>, Andre Hedrick <andre@linux-ide.org>,
       davidsen@tmr.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200303310930.h2V9U3vQ000202@81-2-122-30.bradfords.org.uk>
References: <200303310930.h2V9U3vQ000202@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049108898.15055.2.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 31 Mar 2003 12:08:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-03-31 at 10:30, John Bradford wrote:
> Something that occurs to me - if a machine has non hot-swap capable
> IDE hardware, but has suspend to RAM functionality, presumably it is
> OK from an electronic viewpoint to swap disks?  What about PCI hot
> swap?  Presumably we can remove a non hot-swap IDE controller
> completely, and re-install it with different drives connected?

It is but Linux doesn't support it

