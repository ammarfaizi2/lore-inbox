Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbTLGSts (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Dec 2003 13:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264480AbTLGSts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Dec 2003 13:49:48 -0500
Received: from cafe.hardrock.org ([142.179.182.80]:39809 "EHLO
	cafe.hardrock.org") by vger.kernel.org with ESMTP id S264479AbTLGStr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Dec 2003 13:49:47 -0500
Date: Sun, 7 Dec 2003 11:49:42 -0700 (MST)
From: James Bourne <jbourne@hardrock.org>
To: Chris Frey <cdfrey@netdirect.ca>
cc: Mark Symonds <mark@symonds.net>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 hard lock, 100% reproducible.
In-Reply-To: <20031207133201.A4744@netdirect.ca>
Message-ID: <Pine.LNX.4.51.0312071147070.3356@cafe.hardrock.org>
References: <20031207023650.GA772@symonds.net> <87he0ds3sv.fsf@ceramic.fifi.org>
 <02a901c3bc7b$69294ee0$7a01a8c0@gandalf> <20031207133201.A4744@netdirect.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Dec 2003, Chris Frey wrote:

> On Sat, Dec 06, 2003 at 08:34:32PM -0800, Mark Symonds wrote:
> > Other than that, nothing.  Is there a patch out there 
> > that will simply make 2.4.22 secure?  Things run great
> > on that kernel. 
> 
> Here's the relevant section from patch-2.4.23

Hi,
This is included with the patch set I just posted, 2.4.22-uv3 available at
http://www.hardrock.org/current-updates/linux-2.4.22-uv3-updates.patch.

This also includes patches for some other issues in 2.4.22.  I haven't yet
posted one for 2.4.23 due to some outstanding issues with what appear to be
(or at least could be) hard locks (such as this thread).  Once these are
resolved I will be releasing a -uv for 2.4.23.

Regards
James

> 
> - Chris

-- 
James Bourne                  | Email:            jbourne@hardrock.org          
Unix Systems Administrator    | WWW:           http://www.hardrock.org
Custom Unix Programming       | Linux:  The choice of a GNU generation
----------------------------------------------------------------------
 "All you need's an occasional kick in the philosophy." Frank Herbert  
