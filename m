Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030304AbWBHAKl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030304AbWBHAKl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 19:10:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbWBHAKl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 19:10:41 -0500
Received: from cantor.suse.de ([195.135.220.2]:37004 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030304AbWBHAKk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 19:10:40 -0500
From: Andi Kleen <ak@suse.de>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.6.16-rc1 panic on startup (acpi)
Date: Wed, 8 Feb 2006 01:10:06 +0100
User-Agent: KMail/1.8.2
Cc: Dave Jones <davej@redhat.com>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Andrew Morton <akpm@osdl.org>, Neal Becker <ndbecker2@gmail.com>,
       linux-kernel@vger.kernel.org
References: <ds7cu3$9c0$1@sea.gmane.org> <20060207234043.GB17665@redhat.com> <20060208000715.GA19233@kroah.com>
In-Reply-To: <20060208000715.GA19233@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602080110.06736.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 February 2006 01:07, Greg KH wrote:

> > In the meantime, here's what I got..
> > 
> > http://people.redhat.com/davej/DSC00148.JPG
> 
> Andi, didn't your change for this function make it into Linus's tree?

Yes

See
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=1de6bf33bc4601d856c286ad5c7d515468e24bbb

Workaround is pci=nommconf btw


-Andi

