Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281732AbRKUXBI>; Wed, 21 Nov 2001 18:01:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281754AbRKUXA7>; Wed, 21 Nov 2001 18:00:59 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:1266
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S281732AbRKUXAx>; Wed, 21 Nov 2001 18:00:53 -0500
Date: Wed, 21 Nov 2001 15:00:46 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Helge Hafting <helgehaf@idb.hist.no>
Cc: Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
Subject: Re: x bit for dirs: misfeature?
Message-ID: <20011121150046.A4037@mikef-linux.matchmail.com>
Mail-Followup-To: Helge Hafting <helgehaf@idb.hist.no>,
	Thomas Hood <jdthood@mail.com>, linux-kernel@vger.kernel.org
In-Reply-To: <1006272306.9039.18.camel@thanatos> <3BFB831F.49284E42@idb.hist.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BFB831F.49284E42@idb.hist.no>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 21, 2001 at 11:34:07AM +0100, Helge Hafting wrote:
> Thomas Hood wrote:
> > However, a decent reason for having separate r and x
> > is that "r--" directories _do_ make sense.  When a
> > directory is "r--", its contents can be _listed_ but the
> > directory cannot be browsed.  Observe:     // Thomas Hood
> 
> But is that useful?
> Sure, I can list filenames.  I can't get at filesize
> or permissions.  I can't open the files.  How
> is that useful?  Of course locking people
> out is useful, but why should they need to read
> the filenames?
> 

To taunt them? ;)
