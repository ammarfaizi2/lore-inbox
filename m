Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263787AbUBHQTQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 8 Feb 2004 11:19:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263777AbUBHQTQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 8 Feb 2004 11:19:16 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:9951 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263760AbUBHQTN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 8 Feb 2004 11:19:13 -0500
Date: Sun, 8 Feb 2004 16:19:11 +0000
From: Matthew Wilcox <willy@debian.org>
To: James Bottomley <James.Bottomley@steeleye.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [BK PATCH] bug fixes for scsi for linux-2.6.3-rc1
Message-ID: <20040208161911.GF24334@parcelfarce.linux.theplanet.co.uk>
References: <1076256895.2055.6.camel@mulgrave>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076256895.2055.6.camel@mulgrave>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 08, 2004 at 11:14:54AM -0500, James Bottomley wrote:
> contains four bugfixes for the previous update (actually allow the
> qla2xxx to build as part of the build process and remove its compile
> warnings, fix the mptscsih_exit() discard problem and undelete the
> qlogicfc driver).

Wasn't the mptscsih_exit problem already fixed by:

http://linux.bkbits.net:8080/linux-2.5/patch@1.1500.2.166?nav=index.html|ChangeSet@-3d|cset@1.1500.2.166

(went in via akpm 48 hours ago)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
