Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265165AbTLFNbo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Dec 2003 08:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265166AbTLFNbo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Dec 2003 08:31:44 -0500
Received: from mail3.ithnet.com ([217.64.64.7]:15075 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S265165AbTLFNbl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Dec 2003 08:31:41 -0500
X-Sender-Authentication: net64
Date: Sat, 6 Dec 2003 14:31:39 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: ian.soboroff@nist.gov, linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 includes Andrea's VM?
Message-Id: <20031206143139.0a876c7e.skraw@ithnet.com>
In-Reply-To: <20031203174445.GA29119@mis-mike-wstn.matchmail.com>
References: <9cfptf6vts7.fsf@rogue.ncsl.nist.gov>
	<20031203174445.GA29119@mis-mike-wstn.matchmail.com>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 3 Dec 2003 09:44:45 -0800
Mike Fedyk <mfedyk@matchmail.com> wrote:

> On Wed, Dec 03, 2003 at 09:51:36AM -0500, Ian Soboroff wrote:
> > 
> > I have a machine with 12GB of RAM, and I've been running a 2.4.22-era
> > kernel with Andrea's patches on it, otherwise it dies from lack of
> > lowmem.  
> > 
> > The latest -aa patch is for 2.4.23-pre6, but I see in the 2.4.23
> > Changelog that at least some bits of Andrea's VM were merged.  Should
> > I be able to run a vanilla 2.4.23 on this box?
> > 
> 
> A good amount of the VM was merged into 2.4.23-pre3, so the -aa patches
> against pre6 should show you what is missing.
> 
> That said, I have seen a report that no stock 2.4 kernel would run well >
> 4GB memory until 2.4.23, but he didn't say how much memory he had.

6 GB

Lowmem looks pretty free though. This lets me suspect 12 GB should be working
out, too. If it fails in your tests anyways, please let me know ...

Regards,
Stephan
