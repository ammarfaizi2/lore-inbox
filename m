Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751480AbWEDKID@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751480AbWEDKID (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 May 2006 06:08:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751483AbWEDKID
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 May 2006 06:08:03 -0400
Received: from mail.gmx.net ([213.165.64.20]:1248 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751482AbWEDKIC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 May 2006 06:08:02 -0400
X-Authenticated: #4399952
Date: Thu, 4 May 2006 12:07:34 +0200
From: Florian Paul Schmidt <mista.tapas@gmx.net>
To: "Yogesh Pahilwan" <pahilwan.yogesh@spsoftindia.com>
Cc: "'Steven Rostedt'" <rostedt@goodmis.org>, <linux-kernel@vger.kernel.org>
Subject: Re: Problem while applying patch to 2.6.9 kernel
Message-ID: <20060504120734.096f6a64@mango.fruits>
In-Reply-To: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA/RwgNB/GzEaFbUDhx3/9tAEAAAAA@spsoftindia.com>
References: <Pine.LNX.4.58.0605030809100.24221@gandalf.stny.rr.com>
	<!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAA/RwgNB/GzEaFbUDhx3/9tAEAAAAA@spsoftindia.com>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 May 2006 18:02:45 +0530
"Yogesh Pahilwan" <pahilwan.yogesh@spsoftindia.com> wrote:

> Hi Steven,
> 
> I tried specifying -p2 as follows:
> 
> # patch -p2 < ../../Patches/patch-ext3
> 
> But still getting the same error.
> 
> Please suggest.

I can only suggest using the --dry-run option for patch so you can try
different patchlevels before applying the patch for real.

Flo

-- 
Palimm Palimm!
http://tapas.affenbande.org
