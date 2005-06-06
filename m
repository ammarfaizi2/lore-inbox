Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261236AbVFFIxi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261236AbVFFIxi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 04:53:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261243AbVFFIxi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 04:53:38 -0400
Received: from tms.rz.uni-kiel.de ([134.245.11.89]:42388 "EHLO
	tms.rz.uni-kiel.de") by vger.kernel.org with ESMTP id S261236AbVFFIxg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 04:53:36 -0400
Subject: Re: TPM on IBM thinkcenter S51
From: Torsten Landschoff <tla@comsys.informatik.uni-kiel.de>
To: Kylene Jo Hall <kjhall@us.ibm.com>
Cc: trusted linux <tcimpl2005@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1117810969.5407.11.camel@localhost.localdomain>
References: <20050602220028.3572.qmail@web61014.mail.yahoo.com>
	 <1117790588.6249.5.camel@localhost.localdomain>
	 <1117810969.5407.11.camel@localhost.localdomain>
Content-Type: text/plain
Date: Mon, 06 Jun 2005 10:53:37 +0200
Message-Id: <1118048018.6159.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kylene, 

On Fri, 2005-06-03 at 10:02 -0500, Kylene Jo Hall wrote:
> I maintain the driver and am interested in figuring out what this
> problem is.  Can you please tell me what the device major/minor are

I think this is a misunderstanding. My TPM is working just fine but the
guy I was replying to seems to have some problems.

The old tpm driver (version 2.0) distributed seperately at

  http://www.research.ibm.com/gsal/tcpa/TPM-2.0.tar.gz

did not work for me though. I did not find an obvious problem in it but
noticed there is the tpmdd project on SourceForge and got the driver
from there. That driver is working just fine for me.

> version in the default 2.6.12-rc5.  There are many changes are in the -
> mm2 patch so I will pull down the default tree and make sure the version
> there is working.

Still trying to get a grip on git to track the latest kernel and test
the TPM driver in there. Anyway, the driver I have is working fine. :)
(I am working with an IBM ThinkPad R51 if you care about it).

Greetings

	Torsten

