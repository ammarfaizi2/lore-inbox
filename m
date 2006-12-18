Return-Path: <linux-kernel-owner+w=401wt.eu-S1753715AbWLRKFd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753715AbWLRKFd (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 05:05:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753714AbWLRKFd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 05:05:33 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:55111 "EHLO
	outgoing1.smtp.agnat.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753691AbWLRKFc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 05:05:32 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: util-linux: orphan
Date: Mon, 18 Dec 2006 11:05:13 +0100
User-Agent: KMail/1.9.5
Cc: Karel Zak <kzak@redhat.com>, linux-kernel@vger.kernel.org,
       Henne Vogelsang <hvogel@suse.de>, Olaf Hering <olh@suse.de>,
       "H. Peter Anvin" <hpa@zytor.com>
References: <20061109224157.GH4324@petra.dvoda.cz> <20061218071737.GA5217@petra.dvoda.cz> <Pine.LNX.4.61.0612181031210.21739@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0612181031210.21739@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612181105.13893.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 18 December 2006 10:33, Jan Engelhardt wrote:
> > after few weeks I'm pleased to announce a new "util-linux-ng" project.
> > This project is a fork of the original util-linux (2.13-pre7).
> >
> > The goal of the project is to move util-linux code back to useful state,
> > sync with actual distributions and kernel and make development more
> > transparent end open.
>
> If Adrian [ http://lkml.org/lkml/2006/11/9/262 ] does not want to be
> the maintainer, ask if you can take over, including the name.
> This smells a lot like the RPM case [ http://lwn.net/Articles/196523/ ]
> however, it does not look like anyone is going to call it rpm-ng just
> because the original name is owned by the last maintainer.

rpm.org case is even worse. Original maintainer still develops rpm - at this 
moment version 4.4.7 at http://wraptastic.org/ (while rpm.org starts from 
older 4.4.2 codebase), there is active mailing list, so we have two running 
projects with the same name which is bad thing and will cause confusion.

I hope that there will be one util-linux and one rpm project.

> Regards,
> 	-`J'

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
