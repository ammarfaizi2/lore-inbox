Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264434AbTE0XOX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 19:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264437AbTE0XOX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 19:14:23 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:24403 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S264434AbTE0XOV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 19:14:21 -0400
Date: Tue, 27 May 2003 19:27:32 -0400
From: Pete Zaitcev <zaitcev@redhat.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: Patch to add SysRq handling to 3270 console
Message-ID: <20030527192732.C9007@devserv.devel.redhat.com>
References: <OFDC120FDF.DF290EFE-ONC1256D33.002E7F84@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OFDC120FDF.DF290EFE-ONC1256D33.002E7F84@de.ibm.com>; from schwidefsky@de.ibm.com on Tue, May 27, 2003 at 11:07:30AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
> Date: Tue, 27 May 2003 11:07:30 +0200

>[...]
> And its getting bigger if nothing ever gets integrated. And
> ALL of it is s390 only code. I skipped the common code parts
> which might have caused problems.

Martin, while we're on the topic of skipped common parts:
one common part which I see unlikely to be adopted into Alan
tree, not to mention Marcelo, is the scsi changes for zfcp.

Would you take upon yourself, or make someone to discuss it
with the linux-scsi cabal and get a resolution somehow?

Thanks,
-- Pete
