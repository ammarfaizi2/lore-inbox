Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbTGBKdP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jul 2003 06:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264912AbTGBKdP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jul 2003 06:33:15 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:39337 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S264904AbTGBKdO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jul 2003 06:33:14 -0400
Date: Wed, 2 Jul 2003 16:24:58 +0530
From: Maneesh Soni <maneesh@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.73-mm3
Message-ID: <20030702105458.GH1267@in.ibm.com>
Reply-To: maneesh@in.ibm.com
References: <20030701203830.19ba9328.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030701203830.19ba9328.akpm@digeo.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 02, 2003 at 03:39:54AM +0000, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.5/2.5.73/2.5.73-mm3/
> 
> . The ext2 "free inodes corrupted" problem which Martin saw should be
>   fixed.
> 
> . The ext3 assertion failure which Maneesh hit should be fixed (I can't
>   reproduce this, please retest?)
> 

It is fixed. Ran multiple iterations without any ext3 assertion failure. 

Maneesh

-- 
Maneesh Soni
IBM Linux Technology Center, 
IBM India Software Lab, Bangalore.
Phone: +91-80-5044999 email: maneesh@in.ibm.com
http://lse.sourceforge.net/
