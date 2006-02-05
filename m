Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751766AbWBEP6N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751766AbWBEP6N (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Feb 2006 10:58:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbWBEP6M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Feb 2006 10:58:12 -0500
Received: from dvhart.com ([64.146.134.43]:8599 "EHLO dvhart.com")
	by vger.kernel.org with ESMTP id S1751766AbWBEP6K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Feb 2006 10:58:10 -0500
Message-ID: <43E6208A.3040807@mbligh.org>
Date: Sun, 05 Feb 2006 07:58:02 -0800
From: "Martin J. Bligh" <mbligh@mbligh.org>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marc Koschewski <marc@osknowledge.org>
Cc: Paul Jackson <pj@sgi.com>, dtor_core@ameritech.net, rlrevell@joe-job.com,
       76306.1226@compuserve.com, akpm@osdl.org, linux-kernel@vger.kernel.org,
       rdunlap@xenotime.net
Subject: Re: Wanted: hotfixes for -mm kernels
References: <200602021502_MC3-1-B772-547@compuserve.com> <1138913633.15691.109.camel@mindpipe> <d120d5000602021345i255bb69eydb67bc1b0a448f8d@mail.gmail.com> <20060203100703.GA5691@stiffy.osknowledge.org> <20060204083752.a5c5b058.mbligh@mbligh.org> <20060204185646.f8e4e53e.pj@sgi.com> <20060205085833.GB5663@stiffy.osknowledge.org>
In-Reply-To: <20060205085833.GB5663@stiffy.osknowledge.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Koschewski wrote:
> * Paul Jackson <pj@sgi.com> [2006-02-04 18:56:46 -0800]:
> 
> 
>>Do we need a place to put hotfix patches, or do we just need a list of
>>links to lkml postings to said patches.  Such a list has the advantage
>>of pointing into the discussion surrounding each such fix, and such a
>>list has the advantage of not holding so much redundant data (these
>>patches will be redundant with what was posted on lkml).  Redundant
>>data out of context goes stale, and is less valuable.
>>
>>I can imagine someone (not me ;) keeping a wiki web page, listing for
>>each *-mm and Linus release the particular lkml patch postings that one
>>needs to pick off to get a build and boot.
>>
>>Just brainstorming ...
> 
> 
> That would just come closer to a repositories check-in description. I vote for
> such a thing. If it is a wiki or not.

Why have a list of pointers to go fishing for things out of an email 
archive, rather than just dump the patchs straight into a directory?
Seeing as Andrew seems to have already created a subdir to do this, the 
point seems somewhat moot by now ;-)

M.

