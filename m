Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261675AbSJCPZv>; Thu, 3 Oct 2002 11:25:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261679AbSJCPZv>; Thu, 3 Oct 2002 11:25:51 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:62476 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261675AbSJCPZs>; Thu, 3 Oct 2002 11:25:48 -0400
Date: Thu, 3 Oct 2002 16:31:17 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Shawn <core@enodev.com>
Cc: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021003163117.A23642@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Shawn <core@enodev.com>, linux-kernel@vger.kernel.org,
	evms-devel@lists.sourceforge.net
References: <02100216332002.18102@boiler> <20021003153256.B17513@infradead.org> <20021003100341.B32461@q.mn.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003100341.B32461@q.mn.rr.com>; from core@enodev.com on Thu, Oct 03, 2002 at 10:03:41AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 03, 2002 at 10:03:41AM -0500, Shawn wrote:
> On 10/03, Christoph Hellwig said something like:
> > On Wed, Oct 02, 2002 at 04:33:20PM -0500, Kevin Corry wrote:
> > > EVMS provides a new, stand-alone subsystem to the kernel
> > 
> > i.e. it duplictes existing block layer/volume managment functionality..
> 
> Ok, LVM1 is non-existant if that's what you're referring to. Really,
> this replaces LVM1, but your statement WRT md still has merit. As for
> md duplication, it has been stated already that a preferred approach
> might be to send only core functionality bits for now, leaving that
> out till that question can be addressed.

I speak of all drivers/md/* and fs/partitions/*.

