Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261882AbVEPVUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261882AbVEPVUS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 17:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261884AbVEPVSp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 17:18:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:22469 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261882AbVEPVMN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 17:12:13 -0400
Date: Mon, 16 May 2005 14:11:56 -0700
From: Chris Wright <chrisw@osdl.org>
To: Florian Weimer <fw@deneb.enyo.de>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.11.10
Message-ID: <20050516211156.GE23013@shell0.pdx.osdl.net>
References: <20050516182544.GA9960@kroah.com> <87sm0mx50e.fsf@deneb.enyo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sm0mx50e.fsf@deneb.enyo.de>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Florian Weimer (fw@deneb.enyo.de) wrote:
> * Greg KH:
> 
> > Due to a recently announced security issue with the current kernel, we
> > (the -stable team) are announcing the release of the 2.6.11.10 kernel.
> 
> Would it be possible to cross-reference the vulnerabilities in a
> precise manner, maybe using CVE names?

The ChangeLog has this info (CVE CAN-2005-1264).

http://kernel.org/git/gitweb.cgi?p=linux%2Fkernel%2Fgit%2Fgregkh%2Flinux-2.6.11.y.git;a=log

But, it's reasonble to ask for these in announce email, thanks.
-chris
