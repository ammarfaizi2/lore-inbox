Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263785AbTKXPlV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:41:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbTKXPlU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:41:20 -0500
Received: from cust.7.144.adsl.cistron.nl ([62.216.7.144]:29456 "EHLO
	mail.vroon.org") by vger.kernel.org with ESMTP id S263777AbTKXPlS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:41:18 -0500
Subject: Re: [BUG 2.6.0-test10] SCSI update in CSET 1.1437.1.2 caused
	'Badness'
From: Tony Vroon <tony@vroon.org>
To: Mike Anderson <andmike@us.ibm.com>
Cc: Brad House <brad_mssw@gentoo.org>, linux-kernel@vger.kernel.org,
       Christoph Hellwig <hch@lst.de>, linux-scsi@vger.kernel.org
In-Reply-To: <20031124080919.GA6969@beaverton.ibm.com>
References: <50478.68.105.173.45.1069651886.squirrel@mail.mainstreetsoftworks.com>
	 <20031123234919.72ae0316.akpm@osdl.org>
	 <20031124080919.GA6969@beaverton.ibm.com>
Content-Type: text/plain
Message-Id: <1069688448.4000.2.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 24 Nov 2003 16:40:48 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-11-24 at 09:09, Mike Anderson wrote:
> This patch in the linux-scsi archives should remove this badness
> warning.
> http://marc.theaimsgroup.com/?l=linux-scsi&m=106940008217622&w=2
> 
> It should apply cleanly to test10. I am just updating my view now to
> test10 so I have not tested the patch on test10 yet.
> 
> I did not have it refreshed in time from James to include it in his
> last update.

Confirmed, the badness and backtrace are no longer seen with this patch
applied.

Thank you,
Tony.


