Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265093AbUFVX7N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265093AbUFVX7N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jun 2004 19:59:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265098AbUFVX7N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jun 2004 19:59:13 -0400
Received: from umhlanga.stratnet.net ([12.162.17.40]:50558 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S265093AbUFVX7J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jun 2004 19:59:09 -0400
To: Greg KH <greg@kroah.com>
Cc: tom.l.nguyen@intel.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix MSI-X setup
X-Message-Flag: Warning: May contain useful information
References: <52lligqqlc.fsf@topspin.com> <521xk8qlx1.fsf@topspin.com>
	<52smcop5v7.fsf_-_@topspin.com> <20040622232301.GB13197@kroah.com>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 22 Jun 2004 16:57:53 -0700
In-Reply-To: <20040622232301.GB13197@kroah.com> (Greg KH's message of "Tue,
 22 Jun 2004 16:23:01 -0700")
Message-ID: <52isdjkuwu.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Jun 2004 23:57:53.0403 (UTC) FILETIME=[BB5D54B0:01C458B4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Greg> Applied, thanks.

Great... I would suggest looking at applying the big patch that Long
posted today, too, as it has lots of improvements.

 - Roland

