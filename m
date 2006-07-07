Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932206AbWGGQ3j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932206AbWGGQ3j (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jul 2006 12:29:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWGGQ3j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jul 2006 12:29:39 -0400
Received: from animx.eu.org ([216.98.75.249]:30622 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S932203AbWGGQ3i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jul 2006 12:29:38 -0400
Date: Fri, 7 Jul 2006 12:29:38 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: libATA  PATA status report, new patch
Message-ID: <20060707162938.GA6103@animx.eu.org>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1139244412.10437.32.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1139244412.10437.32.camel@localhost.localdomain>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> With the exception of HPA and serialize support its now pretty close to
> a straight replacement for drivers/ide on x86 systems (and boxes using
> PCI devices only). There is other stuff that wants improving still like
> error recovery on CRC, but its getting close.
> 
> Please remember that functionality equivalence, and much cleaner code
> doesn't mean less bugs yet, there is a *lot* of testing and hammering on
> the code needed before it is production ready for switching.
> 
> 	http://zeniv.linux.org.uk/~alan/IDE
> 
> for 2.6.16-rc2 patches.

I wanted to try this today on 2.6.17 but there is no patch for that version
and the patch for 2.6.17-rc4 doesn't apply cleanly.  Do you have a newer
patch for this or do I just need to use the ole shoe horn?

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
