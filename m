Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264026AbTEWLVF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 May 2003 07:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264027AbTEWLVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 May 2003 07:21:05 -0400
Received: from d12lmsgate-5.de.ibm.com ([194.196.100.238]:27336 "EHLO
	d12lmsgate-5.de.ibm.com") by vger.kernel.org with ESMTP
	id S264026AbTEWLVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 May 2003 07:21:03 -0400
Importance: Normal
Sensitivity: 
Subject: Re: Patch to add SysRq handling to 3270 console
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Pete Zaitcev <zaitcev@redhat.com>,
       linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF62A14D6D.6916E26F-ONC1256D2F.003F0AC1@de.ibm.com>
From: "Martin Schwidefsky" <schwidefsky@de.ibm.com>
Date: Fri, 23 May 2003 13:30:15 +0200
X-MIMETrack: Serialize by Router on D12ML016/12/M/IBM(Release 5.0.9a |January 7, 2002) at
 23/05/2003 13:31:13
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It's attached to RH bug #91338. I append it to this mail.
> I use 2.4.21-rc2-ac2, because pure Marcelo tree does not have
> a recent s390 codebase. He has the old "char *ctrlchar_handle()"
> still, and the patch won't apply.

Good. I'll add this to our code base and include it in our patches.


blue skies,
   Martin


