Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261568AbSJYTFH>; Fri, 25 Oct 2002 15:05:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261569AbSJYTFH>; Fri, 25 Oct 2002 15:05:07 -0400
Received: from bozo.vmware.com ([65.113.40.131]:30982 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id <S261568AbSJYTFG>; Fri, 25 Oct 2002 15:05:06 -0400
Date: Fri, 25 Oct 2002 12:12:02 -0700
From: chrisl@vmware.com
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, linux-kernel@vger.kernel.org
Subject: Re: How to get number of physical CPU in linux from user space?
Message-ID: <20021025191202.GD1397@vmware.com>
References: <F2DBA543B89AD51184B600508B68D4000EA170E9@fmsmsx103.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000EA170E9@fmsmsx103.fm.intel.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 25, 2002 at 11:54:53AM -0700, Nakajima, Jun wrote:
> Recent distributions or the AC tree has additional fields in /proc/cpu,
> which tell
> - physical package id
> - number of threads 
> for each CPU.

That is exactly what I am looking for.

> 
> Using this info, you should be able to detect it. The problem is that they
> are not using the same keywords. I'm asking them to make those fields
> consistent.

Cool. Any idea when will those feature come to stander linux kernel?

Thanks.

Chris


