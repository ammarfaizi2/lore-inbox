Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161298AbWASJ67@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161298AbWASJ67 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 04:58:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161299AbWASJ67
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 04:58:59 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:20459 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161298AbWASJ66 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 04:58:58 -0500
Subject: Re: - add-pselect-ppoll-system-call-implementation-tidy.patch
	removed from -mm tree
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: David Woodhouse <dwmw2@infradead.org>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060119171708.7f856b42.sfr@canb.auug.org.au>
References: <200601190052.k0J0qmKC009977@shell0.pdx.osdl.net>
	 <1137648119.30084.94.camel@localhost.localdomain>
	 <20060119171708.7f856b42.sfr@canb.auug.org.au>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Jan 2006 09:58:11 +0000
Message-Id: <1137664692.8471.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-01-19 at 17:17 +1100, Stephen Rothwell wrote:
> Documentation/CodingStyle says:
> 
> The limit on the length of lines is 80 columns and this is a hard limit.

Its so hard nobody follows it because in many places the results as Dave
correctly points out are just stupid.

Linux 2.6.16-rc1
	Number of files matching *.[c|h]	: 15732
	Number with lines exceeding 80 columns	: 6931
	As a percentage				: 44%

Fix the CodingStyle document instead

Alan



