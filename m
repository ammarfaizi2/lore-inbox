Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264450AbUASX0r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 18:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264540AbUASX0r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 18:26:47 -0500
Received: from mta7.pltn13.pbi.net ([64.164.98.8]:56990 "EHLO
	mta7.pltn13.pbi.net") by vger.kernel.org with ESMTP id S264450AbUASX0V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 18:26:21 -0500
Date: Mon, 19 Jan 2004 15:25:38 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Luca Barbato <lu_zero@gentoo.org>
Cc: cryptoapi-devel@kerneli.org, linux-kernel@vger.kernel.org
Subject: Re: gcloop: compressed loopback support for 2.6
Message-ID: <20040119232538.GW1748@srv-lnx2600.matchmail.com>
Mail-Followup-To: Luca Barbato <lu_zero@gentoo.org>,
	cryptoapi-devel@kerneli.org, linux-kernel@vger.kernel.org
References: <3F5F4F96.4050000@gentoo.org> <400C05E1.70005@gentoo.org> <20040119164139.GR1748@srv-lnx2600.matchmail.com> <400C650C.1070303@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <400C650C.1070303@gentoo.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 20, 2004 at 12:15:24AM +0100, Luca Barbato wrote:
> gcloop isn't file format compatible with the old cloop-0.68 fileformat 
> since I had to use in a different way the index and I prefer ucl instead 
> of zlib.

Maybe you can merge ucl into cloop 2.x, and support both (one compression
scheme per image, of course) in the same codebase?

Has cloop been ported to 2.6?
