Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261449AbULNJBx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261449AbULNJBx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Dec 2004 04:01:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbULNJBx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Dec 2004 04:01:53 -0500
Received: from gwout.thalesgroup.com ([195.101.39.227]:23310 "EHLO
	GWOUT.thalesgroup.com") by vger.kernel.org with ESMTP
	id S261449AbULNJBv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Dec 2004 04:01:51 -0500
Message-ID: <41BEABF7.6060505@fr.thalesgroup.com>
Date: Tue, 14 Dec 2004 10:01:43 +0100
From: "P.O. Gaillard" <pierre-olivier.gaillard@fr.thalesgroup.com>
Reply-To: pierre-olivier.gaillard@fr.thalesgroup.com
Organization: Thales Air Defence
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kyle Moffett <mrmacman_g4@mac.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Linux - open design??
References: <20041214040125.70151.qmail@web90010.mail.scd.yahoo.com> <3A1635D6-4D8D-11D9-B94B-000393ACC76E@mac.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kyle Moffett wrote:
> for that kind of thing to be useful.  Oh, and BTW, concerning a 
> traceability matrix,
> generally it doesn't really exist except for proprietary software.  
> Linux design is
> not "requirements-based" as commercial software is, it's 
> "I-want-this-feature-bad-
> -enough-to-code-it-and-get-it-included-based".  I suspect that companies 
> like
> IBM internally have requirements-based systems to organize their employees
> into various tasks, but publicly there is no such system, aside from 
> "It's broken
> and I fixed it with this patch:".

Hi, some of the APIs of Linux do get tested with full traceability. For 
instance, there is the Open Posix Test Suite. It tests the combination of Linux 
and libraries to check that they conform to Posix specifications.
This seems to be sponsored by Intel as far as I remember.

The OSDL also is writing specifications for Linux (e.g. Carrier Grade Linux) or 
ways to integrate components from the Linux world (e.g. kernel.org sources + 
high res timers from Montavista) to achieve some kind of performance.

I would therefore say that there are in fact roadmaps and specifications for 
Linux (note that this is my opinion as a user). And more seem to be emerging 
even though most of the development is probably driven by the process that Kyle 
just described.

	these were my 2 cents as a user,

	P.O. Gaillard



