Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267377AbUJIUzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267377AbUJIUzE (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 16:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267421AbUJIUvx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 16:51:53 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:11452 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267417AbUJIUsO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 16:48:14 -0400
To: Francois Romieu <romieu@fr.zoreil.com>
Cc: Greg KH <greg@kroah.com>, openib-general@openib.org,
       linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041008202247.GA9653@kroah.com> <528yagn63x.fsf@topspin.com>
	<20041009115028.GA14571@electric-eye.fr.zoreil.com>
From: Roland Dreier <roland@topspin.com>
Date: Sat, 09 Oct 2004 13:47:15 -0700
In-Reply-To: <20041009115028.GA14571@electric-eye.fr.zoreil.com> (Francois
 Romieu's message of "Sat, 9 Oct 2004 13:50:28 +0200")
Message-ID: <52oejbliuk.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] InfiniBand incompatible with the Linux kernel?
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 09 Oct 2004 20:47:16.0225 (UTC) FILETIME=[294D3710:01C4AE41]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Roland> it's orthogonal to any IP issues.  Since the Linux kernel
    Roland> contains a lot of code written to specs available only
    Roland> under NDA (and even reverse-engineered code where specs
    Roland> are completely unavailable), I don't think the expense
    Roland> should be an issue.

    Francois> One can say good bye to peer review.

Yes and no.  Certainly people without specs can't review spec
compliance, but review for coding style, locking bugs, etc. is if
anything more valuable.

Thanks,
  Roland
