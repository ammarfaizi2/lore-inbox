Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932587AbVJCSoO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932587AbVJCSoO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 14:44:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932594AbVJCSoN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 14:44:13 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:61870 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S932587AbVJCSoN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 14:44:13 -0400
Date: Mon, 3 Oct 2005 19:44:11 +0100
From: Al Viro <viro@ftp.linux.org.uk>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, linux-kernel@vger.kernel.org,
       "Tigran A. Aivazian" <tigran@veritas.com>,
       Andrew Stribblehill <ads@wompom.org>
Subject: Re: [PATCH] bfs: fix endian bugs
Message-ID: <20051003184411.GX7992@ftp.linux.org.uk>
References: <20051003171614.GB7554@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003171614.GB7554@mipter.zuzino.mipt.ru>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 09:16:14PM +0400, Alexey Dobriyan wrote:
> Also add endian annotations.

Merged.
