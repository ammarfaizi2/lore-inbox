Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129915AbRB0XQz>; Tue, 27 Feb 2001 18:16:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129910AbRB0XQq>; Tue, 27 Feb 2001 18:16:46 -0500
Received: from smtp1.cern.ch ([137.138.128.38]:25093 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S129900AbRB0XQg>;
	Tue, 27 Feb 2001 18:16:36 -0500
Date: Wed, 28 Feb 2001 00:16:23 +0100
From: Jamie Lokier <lk@tantalophile.demon.co.uk>
To: Tim Waugh <twaugh@redhat.com>
Cc: Don Dugger <ddugger@willie.n0ano.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: binfmt_script and ^M
Message-ID: <20010228001623.A11350@pcep-jamie.cern.ch>
In-Reply-To: <27525795B28BD311B28D00500481B7601F0F2D@ftrs1.intranet.ftr.nl> <20010227143823.A25058@cistron.nl> <20010227202059.C11060@pcep-jamie.cern.ch> <20010227125948.A26290@willie.n0ano.com> <20010227213613.Q13721@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010227213613.Q13721@redhat.com>; from twaugh@redhat.com on Tue, Feb 27, 2001 at 09:36:13PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Waugh wrote:
> > Isn't `perl' overkill?  Why not just:
> > 
> > 	tr -d '\r'
> 
> while read line; do echo ${line%?}; done

And those can be convert a set of files as "fromdos *.c" can they?

:-)
-- Jamie
