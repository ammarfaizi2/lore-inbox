Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263096AbRF0PNF>; Wed, 27 Jun 2001 11:13:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263318AbRF0PMz>; Wed, 27 Jun 2001 11:12:55 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:20997 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S263096AbRF0PMf>;
	Wed, 27 Jun 2001 11:12:35 -0400
To: Robert Love <rml@tech9.net>
Cc: Rik van Riel <riel@conectiva.com.br>,
        "Holzrichter," Bruce <bruce.holzrichter@monster.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: Maintainers master list?
In-Reply-To: <Pine.LNX.4.33L.0106261602380.23373-100000@duckman.distro.conectiva> <993588379.763.0.camel@phantasy>
From: Jes Sorensen <jes@sunsite.dk>
Date: 27 Jun 2001 17:12:18 +0200
In-Reply-To: Robert Love's message of "26 Jun 2001 16:46:05 -0400"
Message-ID: <d3bsnac5yl.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Robert" == Robert Love <rml@tech9.net> writes:

Robert> me.  I took issue with the MAINTAINERS file when Eric brought
Robert> it up originally.  However, I don't think drastic measures
Robert> need to be taken.  I have seen a lot of ideas, including
Robert> Meta-data in the kernel source.

Robert> What I think we need is the simple solution: find a maintainer
Robert> for the file, cleanup the current cruft and misinformation,
Robert> and then actively work to keep the file current.  I am willing
Robert> to be this maintainer.

A good place to start would be to write a script that checks the email
addresses listed in there for bounces say every 6 months (not too
often or people will get grumphy). Oh and maybe include the data about
the person so he/she can verify it's ok, maybe this way we can get
forget this meta-data sillyness.

Robert> I am not a major "maintainer" in the kernel, but I have and do
Robert> contribute.  Thus I think this is a good task for me.  I am
Robert> willing and wanting to do this.  Comments?

Well, you'd become the maintainer maintainer. Thats worth a slot in
the MAINTAINERS file ;-)

Jes
