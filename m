Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265983AbUGEKOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUGEKOO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Jul 2004 06:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265985AbUGEKON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Jul 2004 06:14:13 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:642 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S265983AbUGEKOM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Jul 2004 06:14:12 -0400
Date: Mon, 5 Jul 2004 20:14:02 +1000
From: Nathan Scott <nathans@sgi.com>
To: Fabio Coatti <cova@ferrara.linux.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: XFS problem 2.6.7 vanilla
Message-ID: <20040705201402.A2033082@wobbly.melbourne.sgi.com>
References: <200407051033.10994.cova@ferrara.linux.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200407051033.10994.cova@ferrara.linux.it>; from cova@ferrara.linux.it on Mon, Jul 05, 2004 at 10:33:10AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 05, 2004 at 10:33:10AM +0200, Fabio Coatti wrote:
> We are getting some error trace from xfs. I suppose that this can be due to a 
> faulty HD sector, but it sound strange to me that a HD error can trigger an 
> internal FS failure. We have tried several times to fix this error with XFS 
> repair without succes, so I suppose a hw error, but is the aspected behaviour 
> to get an internal FS error?
> (2.6.7 vanilla)

Could you try a current -bk tree (or XFS CVS on oss.sgi.com,
for 2.6.7 + XFS updates), this should be resolved there now.

thanks.

-- 
Nathan
