Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311757AbSCOHN0>; Fri, 15 Mar 2002 02:13:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311815AbSCOHNH>; Fri, 15 Mar 2002 02:13:07 -0500
Received: from tapu.f00f.org ([66.60.186.129]:50583 "EHLO tapu.f00f.org")
	by vger.kernel.org with ESMTP id <S311757AbSCOHM5>;
	Fri, 15 Mar 2002 02:12:57 -0500
Date: Thu, 14 Mar 2002 23:12:48 -0800
From: Chris Wedgwood <cw@f00f.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: 10.31 second kernel compile
Message-ID: <20020315071248.GA7597@tapu.f00f.org>
In-Reply-To: <20020313085217.GA11658@krispykreme> <460695164.1016001894@[10.10.2.3]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <460695164.1016001894@[10.10.2.3]>
User-Agent: Mutt/1.3.27i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 13, 2002 at 06:44:56AM -0800, Martin J. Bligh wrote:

    I think we need to fix the final phase .... anyone got any ideas
    on parallelizing that?

Redefine the benchmark not to include the final link :)



  --cw
