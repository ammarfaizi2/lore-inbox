Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263302AbSJCO7E>; Thu, 3 Oct 2002 10:59:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263304AbSJCO7E>; Thu, 3 Oct 2002 10:59:04 -0400
Received: from msp-65-29-16-62.mn.rr.com ([65.29.16.62]:45803 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S263302AbSJCO7C>; Thu, 3 Oct 2002 10:59:02 -0400
Date: Thu, 3 Oct 2002 10:03:41 -0500
From: Shawn <core@enodev.com>
To: linux-kernel@vger.kernel.org, evms-devel@lists.sourceforge.net
Subject: Re: EVMS Submission for 2.5
Message-ID: <20021003100341.B32461@q.mn.rr.com>
References: <02100216332002.18102@boiler> <20021003153256.B17513@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20021003153256.B17513@infradead.org>; from hch@infradead.org on Thu, Oct 03, 2002 at 03:32:56PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/03, Christoph Hellwig said something like:
> On Wed, Oct 02, 2002 at 04:33:20PM -0500, Kevin Corry wrote:
> > EVMS provides a new, stand-alone subsystem to the kernel
> 
> i.e. it duplictes existing block layer/volume managment functionality..

Ok, LVM1 is non-existant if that's what you're referring to. Really,
this replaces LVM1, but your statement WRT md still has merit. As for
md duplication, it has been stated already that a preferred approach
might be to send only core functionality bits for now, leaving that
out till that question can be addressed.

Let's take an initially critical look, both philisophically and
technically at this, but also keep an open mind. There /is/ a
difference.

--
Shawn Leas
core@enodev.com

My house is on the median strip of a highway.  You don't really
notice, except I have to leave the driveway doing 60 MPH.
						-- Stephen Wright
