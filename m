Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261356AbUKWVOu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261356AbUKWVOu (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 16:14:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbUKWTJM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 14:09:12 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:54163 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261424AbUKWS4P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 13:56:15 -0500
To: Greg KH <greg@kroah.com>
Cc: Johannes Erdfelt <johannes@erdfelt.com>, linux-kernel@vger.kernel.org
X-Message-Flag: Warning: May contain useful information
References: <20041122713.SDrx8l5Z4XR5FsjB@topspin.com>
	<20041122713.g6bh6aqdXIN4RJYR@topspin.com>
	<20041122222507.GB15634@kroah.com> <527jodbgqo.fsf@topspin.com>
	<20041123064120.GB22493@kroah.com> <52hdnh83jy.fsf@topspin.com>
	<20041123072944.GA22786@kroah.com>
	<20041123175246.GD4217@sventech.com>
	<20041123183813.GA31068@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 23 Nov 2004 10:56:06 -0800
In-Reply-To: <20041123183813.GA31068@kroah.com> (Greg KH's message of "Tue,
 23 Nov 2004 10:38:14 -0800")
Message-ID: <52pt244cop.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: roland@topspin.com
Subject: Re: [openib-general] Re: [PATCH][RFC/v1][4/12] Add InfiniBand SA
 (Subnet Administration) query support
Content-Type: text/plain; charset=us-ascii
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 18:56:12.0287 (UTC) FILETIME=[19DFB8F0:01C4D18E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> No.  RCU is covered by a patent that only allows for it to
    Greg> be implemented in GPL licensed code.  If you want to use RCU
    Greg> in non-GPL code, you need to sign a license agreement with
    Greg> the holder of the RCU patent.

Surely IBM can implement RCU in non-GPLed AIX code or license the
patent to whoever they like, with whatever terms they like?

 - Roland
