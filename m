Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262435AbVDGOyC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262435AbVDGOyC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 10:54:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVDGOyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 10:54:02 -0400
Received: from mail1.kontent.de ([81.88.34.36]:31976 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S262476AbVDGOxt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 10:53:49 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Humberto Massa <humberto.massa@almg.gov.br>
Subject: Re: non-free firmware in kernel modules, aggregation and unclear copyright notice.
Date: Thu, 7 Apr 2005 16:53:43 +0200
User-Agent: KMail/1.6.2
Cc: linux-os@analogic.com, debian-kernel@lists.debian.org,
       debian-legal@lists.debian.org, linux-kernel@vger.kernel.org,
       linux-acenic@sunsite.dk
References: <vVUko.A.NkD.kNTVCB@murphy> <42554407.4010200@almg.gov.br>
In-Reply-To: <42554407.4010200@almg.gov.br>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200504071653.43259.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 7. April 2005 16:30 schrieb Humberto Massa:
> I don't recall anyone asking Intel to give theirs designs away. This 
> thread is about:
> 
> 1. (mainly) some firmware hexdumps present in the kernel source tree are 
> either expicitly marked as being GPL'd or unmarked, in which case one 
> would assume that they would be GPL'd;
> 
> 1a. this means that those firmware hexdumps are not legally 
> distributable by any person besides the firmware copyright holder, 
> because any other person could not comply with the terms of the Section 
> 3 of the GPL (IOW, a third party cannot give you a source code they 
> don't have);

As this has been discussed numerous times and consensus never achieved
and is unlikely to be achieved, I suggest that you keep this discussion
internal to Debian until at least you have patches which can be evaluated
and discussed.  Until then Debian may do to its kernel whatever it pleases
and should be prepared to explain to its users why it removed or altered
drivers.

	Regards
		Oliver
