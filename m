Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271862AbRIFDLv>; Wed, 5 Sep 2001 23:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272386AbRIFDLl>; Wed, 5 Sep 2001 23:11:41 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:9981
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S271862AbRIFDL1>; Wed, 5 Sep 2001 23:11:27 -0400
Date: Wed, 5 Sep 2001 20:11:42 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: gprof, threads and forks
Message-ID: <20010905201142.D1618@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEKODKAA.znmeb@aracnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEKODKAA.znmeb@aracnet.com>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 05, 2001 at 08:04:00PM -0700, M. Edward Borasky wrote:
> fixed?" I need to profile a multi-threaded executable and personally don't
> care about the "fork" case, but I'm sure there are others who would care
> about forks and not threads.

Did you try testing against an -ac kernel?  I believe there is a patch in
there that allows profiling of multi-threaded apps.  If it has made it into
the main kernel, then you can just ignore this message...
