Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265656AbUABVdy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 16:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265661AbUABVdx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 16:33:53 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:9981 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S265656AbUABVcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 16:32:35 -0500
Date: Fri, 2 Jan 2004 13:32:28 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Paolo Ornati <ornati@lycos.it>
Cc: Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
Subject: Re: Strange IDE performance change in 2.6.1-rc1 (again)
Message-ID: <20040102213228.GH1882@matchmail.com>
Mail-Followup-To: Paolo Ornati <ornati@lycos.it>,
	Ed Sweetman <ed.sweetman@wmich.edu>, linux-kernel@vger.kernel.org
References: <200401021658.41384.ornati@lycos.it> <3FF5B3AB.5020309@wmich.edu> <200401022200.22917.ornati@lycos.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200401022200.22917.ornati@lycos.it>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 02, 2004 at 10:04:27PM +0100, Paolo Ornati wrote:
> NR_TESTS=3
> RA_VALUES="64 128 256 8192"

Can you add more samples between 128 and 256, maybe at intervals of 32?

Have there been any ide updates in 2.6.1-rc1?
