Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273033AbTHFBaw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Aug 2003 21:30:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273051AbTHFBaw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Aug 2003 21:30:52 -0400
Received: from mail45-s.fg.online.no ([148.122.161.45]:39866 "EHLO
	mail45.fg.online.no") by vger.kernel.org with ESMTP id S273033AbTHFBav
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Aug 2003 21:30:51 -0400
From: svein@brage.info
Date: Wed, 6 Aug 2003 03:31:25 +0200
To: Alex Goddard <agoddard@purdue.edu>
Cc: Alexander Hoogerhuis <alexh@ihatent.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-tst2-mm4 and ide-scsi
Message-ID: <20030806013125.GB5962@brage.info>
References: <871xw1kyu2.fsf@lapper.ihatent.com> <Pine.LNX.4.56.0308041520540.3506@dust>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0308041520540.3506@dust>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 03:21:53PM -0500, Alex Goddard wrote:
> On Mon, 4 Aug 2003, Alexander Hoogerhuis wrote:
> 
> > Got this oops when burning a CD under mdoerate load on my laptop jsut
> > now:
> 
> [Snip]
> 
> Tried burning without ide-scsi?  As long as you have a recent enough
> version of cdrtools, ide-scsi is no longer necessary in 2.5/2.6.  I
> haven't used ide-scsi in months, and CD burning works just fine.

Well, then, what about cdrdao?
I sometimes need to make more exact copies of a CD than cdrtools allows,
and cdrdao doesn't seem top support IDE devices yet.

- Svein Ove Aas

