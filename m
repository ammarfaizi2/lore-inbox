Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932207AbVJCJjo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932207AbVJCJjo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 05:39:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932209AbVJCJjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 05:39:44 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:6040 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S932207AbVJCJjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 05:39:43 -0400
Date: Mon, 3 Oct 2005 15:18:48 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: sainigargi19 <sainigargi19@indiatimes.com>
Cc: linux-aio@kvack.org, linux-kernel@vger.kernel.org, bcrl@kvack.org,
       sebastien.dugue@bull.net
Subject: Re: buffered AIO patches are giving errors {AIO SUPPORT)-2.6.12-rc6
Message-ID: <20051003094848.GA6603@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <200510030857.OAA20761@WS0005.indiatimes.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200510030857.OAA20761@WS0005.indiatimes.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have you tried using the latest git tree from Ben LaHaise instead, since it
combines the different patchsets properly ?

Ben, do you have a latest and greatest release after aio-2.6.13-rc6-B1 ?
(or do we still back out 90_pipe_aio.diff) 

Regards
Suparna

On Mon, Oct 03, 2005 at 02:44:08PM +0530, sainigargi19 wrote:
> hi suparna..
> 
> I applied ur patches in order to get BUFFER AIO Support on linux-2.6.12-rc6 kernel .
> but they are not getting applied as some of the patches are with respect to 2.6.9 some are with respect to 2.6.12 kernel...
> 
> So can you please tell me how to apply those patches ....
> 
> I have applied ur patches after applying linux-2.6.12-PAIO-* patches provided by bullnet
> 
> Thanks
> 
> 
> 
> 
> --
> To unsubscribe, send a message with 'unsubscribe linux-aio' in
> the body to majordomo@kvack.org.  For more info on Linux AIO,
> see: http://www.kvack.org/aio/
> Don't email: <a href=mailto:"aart@kvack.org">aart@kvack.org</a>

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Lab, India

