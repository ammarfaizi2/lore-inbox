Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263798AbTKXPvn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 10:51:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263800AbTKXPvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 10:51:43 -0500
Received: from cust.7.144.adsl.cistron.nl ([62.216.7.144]:33808 "EHLO
	mail.vroon.org") by vger.kernel.org with ESMTP id S263798AbTKXPvj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 10:51:39 -0500
Subject: Re: Error message when aic7xxx is probing devices "Badness in
	kobject_get" on 2.6.0-test10
From: Tony Vroon <tony@vroon.org>
Reply-To: 1069686284.2444.14.camel@little.lethalwp
To: Jean-Yves Simon <lethalwp@tiscali.be>
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1069689071.4282.7.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Mon, 24 Nov 2003 16:51:11 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jean-Yves,

The following patch fixes this:

On Mon, 2003-11-24 at 09:09, Mike Anderson wrote (in Re: [BUG
2.6.0-test10] SCSI update in CSET 1.1437.1.2 caused 'Badness'): 
> This patch in the linux-scsi archives should remove this badness
> warning.
> http://marc.theaimsgroup.com/?l=linux-scsi&m=106940008217622&w=2
> 
> It should apply cleanly to test10. I am just updating my view now to
> test10 so I have not tested the patch on test10 yet.
> 
> I did not have it refreshed in time from James to include it in his
> last update.

> --
> Michael Anderson
> andmike@us.ibm.com

