Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263976AbTJ1OW0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 09:22:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263980AbTJ1OW0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 09:22:26 -0500
Received: from windsormachine.com ([206.48.122.28]:5100 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S263976AbTJ1OWZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 09:22:25 -0500
Date: Tue, 28 Oct 2003 09:22:22 -0500 (EST)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Heavy disk activity without apperant reason (added more info)
In-Reply-To: <3F9E5DFA.2000008@aitel.hist.no>
Message-ID: <Pine.LNX.4.56.0310280921460.2870@router.windsormachine.com>
References: <3F9BC429.6060608@planet.nl> <3F9D0BBB.9080600@aitel.hist.no>
 <3F9D7120.1020207@planet.nl> <3F9E5DFA.2000008@aitel.hist.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.12.3 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Oct 2003, Helge Hafting wrote:

> dnetc is the most active process here.  I don't know
> what it _is_ - could it be doing lots of disk
> writes?

likely the distributed.net client, shouldnt' normally be doing any disk
writing at all except between blocks.


