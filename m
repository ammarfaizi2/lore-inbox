Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267810AbUJDO74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267810AbUJDO74 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 10:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267818AbUJDO74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 10:59:56 -0400
Received: from relay.pair.com ([209.68.1.20]:1799 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S267810AbUJDO7z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 10:59:55 -0400
X-pair-Authenticated: 64.230.143.188
Date: Mon, 4 Oct 2004 10:59:54 -0400
From: Geoff Oakham <oakhamg@users.sourceforge.net>
To: linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] iRiver ifp filesystem driver
Message-ID: <20041004145954.GA7225@mbl.ca>
Reply-To: Geoff Oakham <oakhamg@users.sourceforge.net>
References: <20041002034624.GA14619@mbl.ca> <20041004144335.GA6770@mbl.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041002034624.GA14619@mbl.ca>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ps. the patch is against 2.6.8.1, but it's reported to work on 2.6.3.

In other words, it was supposed to work with 2.6.9-pre3.  It doesn't.
My bad.  This does:

http://prdownloads.sourceforge.net/ifp-driver/iriverfs-r0.1.0.0pre7.patch.gz?download

(Thanks to lip for pointing this out.)

Geoff

-- 
  PGP fingerprint: 8ADC 92E1 6782 D034 E0E3  8EF4 EA4D 25E3 C17C 48D2
  "If you want to learn more about guns, get a job at [an American]
  convenience store or visit our website at ... " --Michael Moore

