Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751722AbVJTDeX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751722AbVJTDeX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Oct 2005 23:34:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751724AbVJTDeX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Oct 2005 23:34:23 -0400
Received: from ns1.mcdownloads.com ([216.239.132.98]:62353 "EHLO
	mail.3gstech.com") by vger.kernel.org with ESMTP id S1751722AbVJTDeW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Oct 2005 23:34:22 -0400
Subject: Re: 2.6.14-rc4-mm1: udev/sysfs wierdness
From: Aaron Gyes <floam@sh.nu>
To: Greg KH <greg@kroah.com>
Cc: Mathieu Segaud <matt@regala.cx>, linux-kernel@vger.kernel.org
In-Reply-To: <20051019234429.GD18295@kroah.com>
References: <1129610113.10504.4.camel@localhost>
	 <20051018055003.GA10488@kroah.com> <20051018065705.GA11858@kroah.com>
	 <87r7ajdy4v.fsf@barad-dur.minas-morgul.org>
	 <20051019034427.GA15940@kroah.com> <1129701608.10192.1.camel@localhost>
	 <20051019234429.GD18295@kroah.com>
Content-Type: text/plain
Date: Wed, 19 Oct 2005 20:34:11 -0700
Message-Id: <1129779251.7743.1.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-10-19 at 16:44 -0700, Greg KH wrote:
> You need a udev update.  071 has been released which should fix this
> problem (fixes it for me.)  Can you try that out?
> 
> thanks,
> 
> greg k-h

Excuse my igorance, but for the life of me I can't find udev 071.
Obviously it exists somewhere since my distribution (x86_64 Gentoo)
seems to have a package for it, but it's failing to be able to grab it,
and I'm unable to find a tarball anywhere at kernel.org

Aaron Gyes

