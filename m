Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267958AbUI1QNU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267958AbUI1QNU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 12:13:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267957AbUI1QNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 12:13:20 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:17050 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S267958AbUI1QNT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 12:13:19 -0400
To: Paul Jackson <pj@sgi.com>
Cc: greg@kroah.com, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <1096302710971@topspin.com> <10963027102899@topspin.com>
	<20040927131014.695b8212.pj@sgi.com> <52fz53e526.fsf@topspin.com>
	<20040927234333.7cceff47.pj@sgi.com> <52mzzacsyk.fsf@topspin.com>
	<20040928090032.292d12e8.pj@sgi.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 28 Sep 2004 09:13:17 -0700
In-Reply-To: <20040928090032.292d12e8.pj@sgi.com> (Paul Jackson's message of
 "Tue, 28 Sep 2004 09:00:32 -0700")
Message-ID: <52wtyebcde.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][1/2] [RESEND] kobject: add HOTPLUG_ENV_VAR
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 28 Sep 2004 16:13:18.0002 (UTC) FILETIME=[10D03120:01C4A576]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Paul> Perhaps - but perhaps also I've shown you ways to use a
    Paul> function with fewer non-const variables.

Yeah, you've convinced me.  I'll reroll my patches.

Thanks,
  Roland
