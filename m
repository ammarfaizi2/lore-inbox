Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261660AbUAUBeH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 20:34:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261733AbUAUBeG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 20:34:06 -0500
Received: from mail.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:7299 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S261660AbUAUBeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 20:34:03 -0500
Date: Wed, 21 Jan 2004 02:34:01 +0100
From: Matthias Andree <ma+rfs@dt.e-technik.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
       reiserfs-list@namesys.com
Subject: Re: 2.4.24 Oops in find (maybe reiserfs related)
Message-ID: <20040121013401.GB8877@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>,
	reiserfs-list@namesys.com
References: <20040120153242.GA19858@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040120153242.GA19858@merlin.emma.line.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Jan 2004, Matthias Andree wrote:

> This happened during the nightly updatedb, which calls find. The hex
> string is "resi", "locate resi" finds a file in a reiserfs file system,
> /usr.
> 
> reiserfsck 3.6.11 afterwards fixed some
> vpf-10680: The file [103048 103049] has the wrong block count in the
> StatData (2) - corrected to (1)

I have put the vmlinux, bzImage, modules and .config available, if
anyone cares to have a look, send me a mail off-list and I'll by happy
to return the URL. Marcello has been mailed the URL.

-- 
Matthias Andree

Encrypt your mail: my GnuPG key ID is 0x052E7D95
