Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261844AbUCWB0G (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 20:26:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbUCWB0G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 20:26:06 -0500
Received: from mtvcafw.SGI.COM ([192.48.171.6]:47406 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S261844AbUCWB0C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 20:26:02 -0500
Date: Mon, 22 Mar 2004 17:24:04 -0800
From: Paul Jackson <pj@sgi.com>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: colpatch@us.ibm.com, linux-kernel@vger.kernel.org, mbligh@aracnet.com,
       akpm@osdl.org, haveblue@us.ibm.com, hch@infradead.org
Subject: Re: [PATCH] Introduce nodemask_t ADT [0/7]
Message-Id: <20040322172404.75edd177.pj@sgi.com>
In-Reply-To: <20040320093614.GZ2045@holomorphy.com>
References: <1079651064.8149.158.camel@arrakis>
	<20040318165957.592e49d3.pj@sgi.com>
	<1079659184.8149.355.camel@arrakis>
	<20040318175654.435b1639.pj@sgi.com>
	<1079737351.17841.51.camel@arrakis>
	<20040319165928.45107621.pj@sgi.com>
	<20040320031843.GY2045@holomorphy.com>
	<20040319220907.1e07d36f.pj@sgi.com>
	<20040320093614.GZ2045@holomorphy.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I think it's vaguely fair to ask
> those who need it to propagate its use around themselves.

I think it's entirely fair to ask that.

Once the API is easy to grok.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
