Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263834AbUAMJ5j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 04:57:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUAMJ5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 04:57:39 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:54021 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263805AbUAMJ5h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 04:57:37 -0500
Date: Tue, 13 Jan 2004 09:57:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Adrian Bunk <bunk@fs.tum.de>, Andreas Haumer <andreas@xss.co.at>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: [2.4 patch] disallow modular CONFIG_COMX
Message-ID: <20040113095711.A15396@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jeff Garzik <jgarzik@pobox.com>, Adrian Bunk <bunk@fs.tum.de>,
	Andreas Haumer <andreas@xss.co.at>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
References: <Pine.LNX.4.58L.0312311109131.24741@logos.cnet> <3FF2EAB3.1090001@xss.co.at> <20040111013043.GY25089@fs.tum.de> <40031EB1.5030705@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <40031EB1.5030705@pobox.com>; from jgarzik@pobox.com on Mon, Jan 12, 2004 at 05:24:49PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 12, 2004 at 05:24:49PM -0500, Jeff Garzik wrote:
> I agree with the intent...
> 
> At this point, I am tempted to simply comment it out of the Config.in, 
> and let interested parties backport bug fixes and crap from 2.6 if they 
> would like.  The driver has had obvious bugs for a while...

In 2.6 it's as buggy as in 2.4..

