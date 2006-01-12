Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161276AbWALVDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161276AbWALVDd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 16:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161275AbWALVDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 16:03:33 -0500
Received: from mta07-winn.ispmail.ntl.com ([81.103.221.47]:12489 "EHLO
	mta07-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1161272AbWALVDb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 16:03:31 -0500
Message-ID: <43C6C415.7030307@gentoo.org>
Date: Thu, 12 Jan 2006 21:03:17 +0000
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051223)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Matthew Wilcox <matthew@wil.cx>
CC: Jon Mason <jdmason@us.ibm.com>, mulix@mulix.org,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
       linux-pci@atrey.karlin.mff.cuni.cz
Subject: Re: pcnet32 devices with incorrect trident vendor ID
References: <20060112175051.GA17539@us.ibm.com> <43C6C0E6.7030705@gentoo.org> <20060112205714.GK19769@parisc-linux.org>
In-Reply-To: <20060112205714.GK19769@parisc-linux.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox wrote:
> It looks to me like there used to be a quirk that knew about this bug
> and fixed it.
> 
> The reason I say this is that the lspci -x dumps are the same -- both
> featuring the wrong vendor ID.

Good catch. I didn't notice this.

 > Want to dig through 2.4 and look for
> this quirk?

No time for this personally.

Daniel
