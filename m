Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751099AbWJHLme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751099AbWJHLme (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Oct 2006 07:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751100AbWJHLme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Oct 2006 07:42:34 -0400
Received: from mail.gmx.de ([213.165.64.20]:49833 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751099AbWJHLmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Oct 2006 07:42:33 -0400
X-Authenticated: #428038
Date: Sun, 8 Oct 2006 13:42:29 +0200
From: Matthias Andree <matthias.andree@gmx.de>
To: Marc Perkel <marc@perkel.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Read Only File System?
Message-ID: <20061008114229.GA561@merlin.emma.line.org>
Mail-Followup-To: Marc Perkel <marc@perkel.com>,
	linux-kernel@vger.kernel.org
References: <45268412.3040400@perkel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45268412.3040400@perkel.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.13 (2006-09-01)
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 06 Oct 2006, Marc Perkel wrote:

> Not sure where to ask this question so I'll try here. I have a Raid 0 
> EXT3 file system that is coming up read only. I don't think it's raid 
> related but not sure why it's stuck on read only.

1. check dmesg
2. run a recent version of e2fsprogs (aka e2fsck)

-- 
Matthias Andree
