Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315779AbSFCXRp>; Mon, 3 Jun 2002 19:17:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315783AbSFCXRo>; Mon, 3 Jun 2002 19:17:44 -0400
Received: from pc2-cwma1-5-cust12.swa.cable.ntl.com ([80.5.121.12]:52980 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S315779AbSFCXRn>; Mon, 3 Jun 2002 19:17:43 -0400
Subject: Re: isofs unhide option:  troubles with Wine
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy White <jwhite@codeweavers.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1023123957.8071.140.camel@jwhite>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 04 Jun 2002 01:23:18 +0100
Message-Id: <1023150198.23878.93.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-06-03 at 18:05, Jeremy White wrote:
> > possible rather than impossible. Question is - why was hide the default
> > and what was that decision based upon ?
> 
> I agree with Alan - this is the key question.  
> 
> I would further argue that silence in response to this question
> suggests that there was no carefully considered reason;
> presumably a good hacker just followed the spec, without considering how
> these CDs are actually used.
> 
> It further suggests to me that I should prep a patch.

Go for it. I'll give it a test in the -ac tree happily. If nobody
screams it can then go upstream.

