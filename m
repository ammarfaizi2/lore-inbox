Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268255AbTCFSRp>; Thu, 6 Mar 2003 13:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268256AbTCFSRo>; Thu, 6 Mar 2003 13:17:44 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:47880 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S268255AbTCFSRo>;
	Thu, 6 Mar 2003 13:17:44 -0500
Date: Thu, 6 Mar 2003 10:18:30 -0800
From: Greg KH <greg@kroah.com>
To: Ian Soboroff <ian.soboroff@nist.gov>
Cc: linux-kernel@vger.kernel.org
Subject: Re: TransMeta longrun control utility maintainer?
Message-ID: <20030306181829.GA3431@kroah.com>
References: <9cfy93s4mbd.fsf@rogue.ncsl.nist.gov>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9cfy93s4mbd.fsf@rogue.ncsl.nist.gov>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 06, 2003 at 09:11:18AM -0500, Ian Soboroff wrote:
> 
> I know this isn't the best place to ask, but maybe someone here knows.
> 
> Who is maintaining the longrun(1) (should probably be longrun(8))
> utility?  The author is listed as Daniel Quinlan
> <quinlan@transmeta.com>, but mail to that address bounces.
> 
> The longrun utility frobs the MSR on TransMeta processors to switch
> between performance and economy modes.
> 
> On my laptop, currently running 2.4.21-pre5-ac1, I get the following
> error:

It works for me just fine on 2.4.21-pre5, have you tried that kernel
version?

thanks,

greg k-h
