Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264701AbTF0SlY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jun 2003 14:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264706AbTF0SlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jun 2003 14:41:24 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:23989 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S264701AbTF0SlU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jun 2003 14:41:20 -0400
Message-ID: <3EFC92E9.4040806@austin.ibm.com>
Date: Fri, 27 Jun 2003 13:54:33 -0500
From: Mark Peloquin <peloquin@austin.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Hansen <haveblue@us.ibm.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>, linstab <linstab@osdl.org>,
       ltp-results <ltp-results@lists.sourceforge.net>
Subject: Re: [BENCHMARK] 2.5.73-bk3, -bk4, -mjb1 regression test results
References: <3EFC8E3D.6050505@austin.ibm.com> <1056739431.9085.21.camel@nighthawk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Dave Hansen wrote:

>On Fri, 2003-06-27 at 11:34, Mark Peloquin wrote:
>  
>
>>Nightly Regression Summary
>>for
>>    
>>
>...
>
>Have you ever had these regression tests run against the same kernel?  
>say, 2.5.73 vs 2.5.73
>
>How often do you see improvements or regressions reported then?
>  
>

Its benchmark specific. Currently dbench, specjbb, and lmbench have a 
few problematic data points that aren't terribly repeatable. So on the 
same kernel, one can see improvements and regressions. That said, the 
majority of data points are very repeatable and give good indications of 
real change. We will continue to tweak things here and there to reduce 
the number of false positives.

Mark


