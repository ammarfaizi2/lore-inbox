Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263946AbTL2Syy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 13:54:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTL2Syy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 13:54:54 -0500
Received: from mta4.rcsntx.swbell.net ([151.164.30.28]:38801 "EHLO
	mta4.rcsntx.swbell.net") by vger.kernel.org with ESMTP
	id S263946AbTL2Sy2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 13:54:28 -0500
Date: Mon, 29 Dec 2003 10:53:57 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Muli Ben-Yehuda <mulix@mulix.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [CFT/PATCH] give sound/oss/trident a holiday cleanup for 2.6
Message-ID: <20031229185357.GJ1882@matchmail.com>
Mail-Followup-To: Muli Ben-Yehuda <mulix@mulix.org>,
	Linux-Kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@zip.com.au>
References: <20031229183846.GI13481@actcom.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031229183846.GI13481@actcom.co.il>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 29, 2003 at 08:38:47PM +0200, Muli Ben-Yehuda wrote:
> - run the code through Lindent, and then fix it manually (this is the
> bulk of the patch) 

Any chance you could split the changes before and after the lindent?
