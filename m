Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261853AbUKVXDP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261853AbUKVXDP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Nov 2004 18:03:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261172AbUKVXBA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Nov 2004 18:01:00 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:59135 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261205AbUKVW6v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Nov 2004 17:58:51 -0500
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org
X-Message-Flag: Warning: May contain useful information
References: <20041122714.taTI3zcdWo5JfuMd@topspin.com>
	<20041122714.AyIOvRY195EGFTaO@topspin.com>
	<20041122225335.GE15634@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Mon, 22 Nov 2004 14:58:45 -0800
In-Reply-To: <20041122225335.GE15634@kroah.com> (Greg KH's message of "Mon,
 22 Nov 2004 14:53:35 -0800")
Message-ID: <52sm71bie2.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [PATCH][RFC/v1][11/12] Add InfiniBand Documentation files
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 22 Nov 2004 22:58:50.0397 (UTC) FILETIME=[D4C544D0:01C4D0E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Why do you propose such a "deep" nesting of directories for
    Greg> umad devices?  That's not the LANNANA way.

No real reason, I'm open to better suggestions.

    Greg> Oh, have you asked for a real major number to be reserved
    Greg> for umad?

No, I think we're fine with a dynamic major.  Is there any reason to
want a real major?

 - Roland
