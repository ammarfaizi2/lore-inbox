Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264732AbSJXGu2>; Thu, 24 Oct 2002 02:50:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265176AbSJXGu1>; Thu, 24 Oct 2002 02:50:27 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:60608 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S264732AbSJXGu1>; Thu, 24 Oct 2002 02:50:27 -0400
Date: Thu, 24 Oct 2002 12:40:16 +0530
From: "Vamsi Krishna S ." <vamsi@in.ibm.com>
To: Matthew Wilcox <willy@debian.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel hooks interface available to non-GPL modules?
Message-ID: <20021024124016.A30624@in.ibm.com>
Reply-To: vamsi@in.ibm.com
References: <20021023144227.O27461@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20021023144227.O27461@parcelfarce.linux.theplanet.co.uk>; from willy@debian.org on Wed, Oct 23, 2002 at 02:42:27PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Oct 23, 2002 at 02:42:27PM +0100, Matthew Wilcox wrote:
> 
> I'm not sure this is a great idea.  OK, your DECLARE_HOOK macros are _GPL
> (and why are they _NOVERS_GPL?  Surely this is the exact kind of thing
> you want versioned?), but I wouldn't have to use the DECLARE_HOOK macros,
> would I?

I agree and have exported hook interfaces with _GPL in the latest version of
the patch. It will be at http://www-124.ibm.com/linux/patches/?patch_id=595.

-- 
Vamsi Krishna S.
Linux Technology Center,
IBM Software Lab, Bangalore.
Ph: +91 80 5044959
Internet: vamsi@in.ibm.com
