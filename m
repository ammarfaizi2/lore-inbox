Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261935AbUBWR3w (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 12:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261972AbUBWR3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 12:29:52 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49812 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261935AbUBWR30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 12:29:26 -0500
Date: Mon, 23 Feb 2004 17:29:21 +0000
From: Matthew Wilcox <willy@debian.org>
To: "Bagalkote, Sreenivas" <sreenib@lsil.com>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'linux-scsi@vger.kernel.org'" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH][BUGFIX] : megaraid patch for 2.10.1 (irq disable bug fix)
Message-ID: <20040223172921.GD25779@parcelfarce.linux.theplanet.co.uk>
References: <0E3FA95632D6D047BA649F95DAB60E570230C730@exa-atlanta.se.lsil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0E3FA95632D6D047BA649F95DAB60E570230C730@exa-atlanta.se.lsil.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 23, 2004 at 12:24:31PM -0500, Bagalkote, Sreenivas wrote:
> Hello all,
> 
> The following patch fixes a bug in megaraid driver version 2.10.1
> where irq was erroneously being disabled.

Could we have a later version than 2.00.3 in 2.6 please?

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
