Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbTJGSoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 14:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262731AbTJGSoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 14:44:09 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:40320 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262730AbTJGSoH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 14:44:07 -0400
Date: Tue, 7 Oct 2003 19:44:05 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: insecure <insecure@mail.od.ua>
Cc: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mru@users.sourceforge.net>,
       linux-kernel@vger.kernel.org
Subject: Re: devfs and udev
Message-ID: <20031007184405.GX7665@parcelfarce.linux.theplanet.co.uk>
References: <20031007131719.27061.qmail@web40910.mail.yahoo.com> <yw1xllrxdvhh.fsf@users.sourceforge.net> <200310072128.09666.insecure@mail.od.ua>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310072128.09666.insecure@mail.od.ua>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 07, 2003 at 09:28:09PM +0300, insecure wrote:
 
> I am pro-devfs guy too.
> If its internals are bad in some way or other, internals
> may be fixed. But devfs userspace-visible interface was
> not flawed (IMO).
> 
> What am I supposed to do, starting to use mknod again? Uggggh...

	Feel free to try and redesign the internals until they become
acceptable.  Since *nobody* had achieved that and those who'd tried
had generally come to conclusion that things is FUBAR...  Good luck,
but I'm not holding my breath.
