Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135794AbRDTETe>; Fri, 20 Apr 2001 00:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135796AbRDTETZ>; Fri, 20 Apr 2001 00:19:25 -0400
Received: from atlrel2.hp.com ([156.153.255.202]:39111 "HELO atlrel2.hp.com")
	by vger.kernel.org with SMTP id <S135794AbRDTETR>;
	Fri, 20 Apr 2001 00:19:17 -0400
Date: Thu, 19 Apr 2001 22:19:16 -0600
To: james rich <james.rich@m.cc.utah.edu>
Cc: Matthew Wilcox <willy@ldl.fc.hp.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        linux-kernel@vger.kernel.org, parisc-linux@parisc-linux.org
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
Message-ID: <20010419221916.K4217@zumpano.fc.hp.com>
In-Reply-To: <20010419211749.I4217@zumpano.fc.hp.com> <Pine.GSO.4.05.10104192201330.8316-100000@pipt.oz.cc.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.05.10104192201330.8316-100000@pipt.oz.cc.utah.edu>; from james.rich@m.cc.utah.edu on Thu, Apr 19, 2001 at 10:07:22PM -0600
From: willy@ldl.fc.hp.com (Matthew Wilcox)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2001 at 10:07:22PM -0600, james rich wrote:
> Doesn't this seem a little like the problems occurring with lvm right now?
> A separate tree maintained with the maintainers not wanting others
> submitting patches that conflict with their particular tree?  It seems
> that any project should be able to submit any patch against The One True
> Tree: Linus' tree.

every single architecture has their own development tree.  the pa project
has not been running as long as the other ports, and has a large amount of
development going on.  i count 28 commits for april (so far), 75 commits
for march, 187 for february and 112 for january (to the kernel tree, other
parts of the port also have commit messages).  linus would go insane if
we sent him every single one of those patches individually.  and we'd
go insane trying to keep up with what he'd taken and what he'd dropped.

until you've actually tried doing this, please don't attempt to criticise.

