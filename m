Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263504AbTKFLvt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Nov 2003 06:51:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTKFLvt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Nov 2003 06:51:49 -0500
Received: from supreme.pcug.org.au ([203.10.76.34]:44450 "EHLO pcug.org.au")
	by vger.kernel.org with ESMTP id S263504AbTKFLvs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Nov 2003 06:51:48 -0500
Date: Thu, 6 Nov 2003 22:51:01 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: agl@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net
Subject: Re: [RFC] Smarter stack traces using the frame pointer
Message-Id: <20031106225101.33e15a48.sfr@canb.auug.org.au>
In-Reply-To: <119200000.1068062194@flay>
References: <1067984031.544.23.camel@agtpad>
	<20031105132138.59326dd4.sfr@canb.auug.org.au>
	<119200000.1068062194@flay>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Nov 2003 11:56:34 -0800 "Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> What's the difference between the two patches, apart from the size?
> Better error handling / functionality somehow? 

I think mine handles more cases, but is much more of a hack ...

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
