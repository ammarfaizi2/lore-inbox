Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261281AbTDOL4V (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 07:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTDOLzs 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 07:55:48 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:16574
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261293AbTDOLyu (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 07:54:50 -0400
Subject: RE: kernel support for non-English user messages
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert White <rwhite@casabyte.com>
Cc: Riley Williams <Riley@Williams.Name>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <PEEPIDHAKMCGHDBJLHKGKEIFCHAA.rwhite@casabyte.com>
References: <PEEPIDHAKMCGHDBJLHKGKEIFCHAA.rwhite@casabyte.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1050404902.27744.10.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 15 Apr 2003 12:08:31 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-15 at 04:44, Robert White wrote:
> Message codes would be *VERY BAD* anyway.  As soon as you start that, then
> you need a numbering authority and all that nonsense.

In the embedded world that isnt a problem. Ripping all the strings out
and replacing them with numbers is a useful process even if "Error
134117" is only constant in your product line.

