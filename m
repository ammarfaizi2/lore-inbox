Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267573AbTBGE04>; Thu, 6 Feb 2003 23:26:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267638AbTBGE04>; Thu, 6 Feb 2003 23:26:56 -0500
Received: from holomorphy.com ([66.224.33.161]:4554 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S267573AbTBGE0z>;
	Thu, 6 Feb 2003 23:26:55 -0500
Date: Thu, 6 Feb 2003 20:35:34 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@digeo.com>, patmans@us.ibm.com, mbligh@aracnet.com,
       James.Bottomley@steeleye.com, mikeand@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: Broken SCSI code in the BK tree (was: 2.5.59-mm8)
Message-ID: <20030207043534.GU1599@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@digeo.com>, patmans@us.ibm.com,
	mbligh@aracnet.com, James.Bottomley@steeleye.com,
	mikeand@us.ibm.com, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <211570000.1044508407@[10.10.2.4]> <265170000.1044564655@[10.10.2.4]> <275930000.1044570608@[10.10.2.4]> <1044573927.2332.100.camel@mulgrave> <20030206172434.A15559@beaverton.ibm.com> <293060000.1044583265@[10.10.2.4]> <20030206182502.A16364@beaverton.ibm.com> <20030206230544.E19868@redhat.com> <20030206201939.27216fb1.akpm@digeo.com> <20030206232440.F19868@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030206232440.F19868@redhat.com>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2003 at 08:19:39PM -0800, Andrew Morton wrote:
>> http://www.feral.com/isp.html seems to be 2.4.x-only.

On Thu, Feb 06, 2003 at 11:24:40PM -0500, Doug Ledford wrote:
> As answered elsewhere, the 2.5 port isn't done yet.  That's why I said in 
> my email "if it's ready for 2.5" because I was afraid Matthew hadn't 
> gotten around to doing the 2.5 update yet.  However, if no one else can do 
> it, I can make a 2.5 update of this driver happen (I don't suspect it 
> would be that hard actually, not *that* much has to change).

This driver's bugginess is a _major_ nuisance to me and I don't have
the SCSI know-how to fix it myself. I'd _love_ to test a driver with a
prayer of working anytime this century.

Thanks.

-- wli
