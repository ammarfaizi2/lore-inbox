Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266229AbUAGQLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Jan 2004 11:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266230AbUAGQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Jan 2004 11:11:19 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:43014 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S266229AbUAGQLS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Jan 2004 11:11:18 -0500
Date: Wed, 7 Jan 2004 16:11:10 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [2.4 patch] fix CONFIG_QFMT_V2 description
Message-ID: <20040107161110.A30210@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Adrian Bunk <bunk@fs.tum.de>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	linux-kernel@vger.kernel.org
References: <20040107155940.GB11523@fs.tum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040107155940.GB11523@fs.tum.de>; from bunk@fs.tum.de on Wed, Jan 07, 2004 at 04:59:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 07, 2004 at 04:59:40PM +0100, Adrian Bunk wrote:
> In 2,4, the CONFIG_QFMT_V2 short description talks about a
> "VFS v0 quota format". Is this really correct, or is the patch below 
> that uses the "Quota format v2 support" text from 2.6 instead correct?

I think you should ask Jan Kara instead what he prefers.  This VFS v0
stuff is his invention.  Personally I'm a little confused about the proper
naming, too.

