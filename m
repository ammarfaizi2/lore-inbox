Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbREUA3z>; Sun, 20 May 2001 20:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262277AbREUA3p>; Sun, 20 May 2001 20:29:45 -0400
Received: from smtp1.cern.ch ([137.138.128.38]:21254 "EHLO smtp1.cern.ch")
	by vger.kernel.org with ESMTP id <S262276AbREUA3c>;
	Sun, 20 May 2001 20:29:32 -0400
To: John Cowan <jcowan@reutershealth.com>
Cc: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch> <3B054500.2090408@reutershealth.com>
From: Jes Sorensen <jes@sunsite.dk>
Date: 21 May 2001 02:29:17 +0200
In-Reply-To: John Cowan's message of "Fri, 18 May 2001 11:51:28 -0400"
Message-ID: <d31ypj1r4y.fsf@lxplus015.cern.ch>
User-Agent: Gnus/5.070096 (Pterodactyl Gnus v0.96) Emacs/20.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "John" == John Cowan <jcowan@reutershealth.com> writes:

John> Jes Sorensen wrote:
>> Telling them to install an updated gcc for kernel compilation is a
>> necessary evil, which can easily be done without disturbing the
>> rest of the system. Updating the system's python installation is
>> not a reasonable request.

John> Au contraire.  It is very reasonable to have both python and
John> python2 installed.  Having two different gcc versions installed
John> is a big pain in the arse.

It's not unreasonable to have both installed, it's unreasonable to
require it.

Eric seems to think he can tell every distributor to ship Python2
tomorrow. Well it's a fine dream but it's not going to happen; Most
distributors do not ship new major versions of tools in their minor
number release versions. I've seen him mention the number 6 months
until everybody ships it, but a) thats not going to happen Red Hat is
currently at 7.1 (if one looks at their release history, one would say
there is a good chance there will be a 7.2) not to mention the release
rate of Debian (not sure about the current state of all other
distributions). 18 months is more realistic for it to be deployed
widely enough.

>> So far I haven't heard a single developer say something positive
>> about CML2, the most positive I have heard so far has been
>> "whatever", "it's his choice", "I don't care", "I want to
>> hack". The majority are of the "NO!" and "you got to be kiddin'".

John> Anonymized hearsay evidence is less than convincing.

Well I don't like to quote personal conversations without peoples'
approval, now both David Woodhouse and Arjan are two examples.

Jes
