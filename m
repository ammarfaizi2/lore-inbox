Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262343AbRERPyN>; Fri, 18 May 2001 11:54:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262358AbRERPyD>; Fri, 18 May 2001 11:54:03 -0400
Received: from mail.reutershealth.com ([204.243.9.36]:12229 "EHLO
	mail.reutershealth.com") by vger.kernel.org with ESMTP
	id <S262343AbRERPxv>; Fri, 18 May 2001 11:53:51 -0400
Message-ID: <3B054500.2090408@reutershealth.com>
Date: Fri, 18 May 2001 11:51:28 -0400
From: John Cowan <jcowan@reutershealth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.2-2 i686; en-US; rv:0.9) Gecko/20010505
X-Accept-Language: en
MIME-Version: 1.0
To: Jes Sorensen <jes@sunsite.dk>
CC: esr@thyrsus.com, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Re: CML2 design philosophy heads-up
In-Reply-To: <20010505192731.A2374@thyrsus.com> <d33da9tjjw.fsf@lxplus015.cern.ch> <20010513112543.A16121@thyrsus.com> <d3d79awdz3.fsf@lxplus015.cern.ch> <20010515173316.A8308@thyrsus.com> <d3wv7eptuz.fsf@lxplus015.cern.ch>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jes Sorensen wrote:

> Telling them to install an updated gcc for kernel compilation
> is a necessary evil, which can easily be done without disturbing the
> rest of the system. Updating the system's python installation is not a
> reasonable request.


Au contraire.  It is very reasonable to have both python and python2
installed.  Having two different gcc versions installed is a big pain
in the arse.

> So far I haven't heard a single
> developer say something positive about CML2, the most positive I have
> heard so far has been "whatever", "it's his choice", "I don't care",
> "I want to hack". The majority are of the "NO!" and "you got to be
> kiddin'".


Anonymized hearsay evidence is less than convincing.


> Let's just say you didn't exactly give peoiple a good impression with
> the trolling around on how everybody had to change their option names 
> and how important it was for the world.


Decidedly bad form to criticize someone for a bug (in this case,
a design bug) that's already been fixed.  If that behavior starts,
who shall escape hanging?

 
> I do not have Python2 installed and I do not plan to, if you
> change CML2 to use a reasonable programming language I might give it a
> try.


Those who don't remember the past are condemned to repeat it.

John Cowan, _novus homo_ (Latin for "upstart")

-- 
There is / one art             || John Cowan <jcowan@reutershealth.com>
no more / no less              || http://www.reutershealth.com
to do / all things             || http://www.ccil.org/~cowan
with art- / lessness           \\ -- Piet Hein

