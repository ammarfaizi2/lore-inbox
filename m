Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261353AbUBTRb7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 12:31:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbUBTRb7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 12:31:59 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:50565 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261353AbUBTRbr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 12:31:47 -0500
Date: Fri, 20 Feb 2004 12:22:37 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
Message-ID: <20040220172237.GA9918@certainkey.com>
References: <4035334A.7030407@gmx.net> <1077229237.17707.9.camel@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1077229237.17707.9.camel@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If others on the list care to do this, I'll give recommendation on how to 
implement the security (hmac, salt, iteration counts, etc).  But I think
this may break backward compatibility.  Can anyone speak to this?

JLC


On Thu, Feb 19, 2004 at 11:20:37PM +0100, Christophe Saout wrote:
> Exactly. I like the format LVM2 uses. It basically puts the metadata
> into a text file with a magic header string there.

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
