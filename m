Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262204AbUCIVLn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Mar 2004 16:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262194AbUCIVLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Mar 2004 16:11:43 -0500
Received: from ambr.mtholyoke.edu ([138.110.1.10]:8978 "EHLO
	ambr.mtholyoke.edu") by vger.kernel.org with ESMTP id S262204AbUCIVLm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Mar 2004 16:11:42 -0500
Date: Tue, 9 Mar 2004 16:11:41 -0500 (EST)
From: Ron Peterson <rpeterso@MtHolyoke.edu>
To: linux-kernel@vger.kernel.org
Subject: Re: network / performance problems
In-Reply-To: <Pine.OSF.4.21.0403090949380.79394-100000@mhc.mtholyoke.edu>
Message-ID: <Pine.OSF.4.21.0403091609220.367714-100000@mhc.mtholyoke.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 9 Mar 2004, Ron Peterson wrote:
> 
> The machines is not really thrashing yet, but I'd expect in another couple
> days, if experience holds, that it will be gonzo.  I'd like to revert back
> to 2.4.20 before then, as this is a production machine.  I'll leave it
> going as is for a short while, however, in case anyone has any suggestions
> about things I should look at while it's misbehaving.

I'm now dumping profile information from sam to the following location
every fifteen minutes:

http://depot.mtholyoke.edu:8080/tmp/sam-profile/

I'm thinking I'll reboot sam to 2.4.20 tomorrow morning, unless someone
says they'd like some more data.

Best.

_________________________
Ron Peterson
Network & Systems Manager
Mount Holyoke College

