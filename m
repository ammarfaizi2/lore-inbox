Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135801AbRDTExy>; Fri, 20 Apr 2001 00:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135805AbRDTExo>; Fri, 20 Apr 2001 00:53:44 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:38922 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S135804AbRDTExf>;
	Fri, 20 Apr 2001 00:53:35 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200104200452.f3K4q3X07411@saturn.cs.uml.edu>
Subject: Re: OK, let's try cleaning up another nit. Is anyone paying attention?
To: willy@ldl.fc.hp.com (Matthew Wilcox)
Date: Fri, 20 Apr 2001 00:52:03 -0400 (EDT)
Cc: james.rich@m.cc.utah.edu (james rich),
        willy@ldl.fc.hp.com (Matthew Wilcox),
        esr@thyrsus.com (Eric S. Raymond), linux-kernel@vger.kernel.org,
        parisc-linux@parisc-linux.org
In-Reply-To: <20010419221916.K4217@zumpano.fc.hp.com> from "Matthew Wilcox" at Apr 19, 2001 10:19:16 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthew Wilcox writes:
> On Thu, Apr 19, 2001 at 10:07:22PM -0600, james rich wrote:

>> Doesn't this seem a little like the problems occurring with lvm right now?
>> A separate tree maintained with the maintainers not wanting others
>> submitting patches that conflict with their particular tree?  It seems
>> that any project should be able to submit any patch against The One True
>> Tree: Linus' tree.
>
> every single architecture has their own development tree.

This sucks for users of that architecture. Also, though not
applicable to PA-RISC, it sucks for sub-architecture porters.
(by sub-architecture I mean: Mac, PReP, PowerCore, BeBox, etc.)

It's hard enough deciding between Linus and Alan. I'm not at all
happy trying to pick through obscure CVS and BitKeeper trees that
might not be up-to-data with the latest mainstream bug fixes.

> the pa project
> has not been running as long as the other ports, and has a large amount of
> development going on.  i count 28 commits for april (so far), 75 commits
> for march, 187 for february and 112 for january (to the kernel tree, other
> parts of the port also have commit messages).  linus would go insane if
> we sent him every single one of those patches individually.  and we'd
> go insane trying to keep up with what he'd taken and what he'd dropped.
> 
> until you've actually tried doing this, please don't attempt to criticise.

Have _you_ tried? If I recall correctly, Linus spoke out against the
PowerPC people doing the exact same thing. So unless you get told to
quit annoying him with patches, sending them is the safe bet.

Well here we go. It's about IrDA though, not PowerPC. Read it!
http://lwn.net/2000/1109/a/lt-IrDA.php3

