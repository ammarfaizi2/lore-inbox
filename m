Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274365AbRJABNk>; Sun, 30 Sep 2001 21:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274368AbRJABNb>; Sun, 30 Sep 2001 21:13:31 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:7951 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S274365AbRJABNX>;
	Sun, 30 Sep 2001 21:13:23 -0400
Date: Sun, 30 Sep 2001 18:15:10 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: "M. Edward Borasky" <znmeb@aracnet.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: [OT] New Anti-Terrorism Law makes "hacking" punishable by life
 in prison
In-Reply-To: <HBEHIIBBKKNOBLMPKCBBEEOFDNAA.znmeb@aracnet.com>
Message-ID: <Pine.LNX.4.10.10109301754350.28318-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 30 Sep 2001, M. Edward Borasky wrote:
> The security features are there in Windows if the users and sysadmins are
> willing to implement them. Windows NT has had C2 available for quite some
> time; they couldn't sell to DOD if they didn't. A good MSCE / security
> specialist makes a lot of money. It's for the most part laziness on the part
> of Windows users that allows malicious code to circulate, not any inherent
> weakness in the Microsoft tool set. The technology exists.

Ok I'll bite .. and only because I'm stuck dealing with W2k on occasion..
Yea look and drool at the fined grained access controls MS has .. then go
try getting IIS to run as anything other than administrator.. 

Access controls are good only when used.  MS security doesn't ever seem to
take possible flaws in daemons into account.

Now add the fun of things mysteriously breaking when hotfixes are applied.
Wonder why admins are afraid to apply them?  I have a W2k Machine that now
crashes twice weekly since the latest updates were applied. That's up from
a crash every 1 or 2 months.

Off hand I'd call that an inherent weakness.

Meanwhile Apache on my boxes either runs as "nobody" or as a user
dedicated to the web server.  Linux may not have the cool access controls
but at least the existing security controls are actually USED.
 
> 
> > I'm not saying Linux/Unix users should rest on their
> > laurels or be lulled into a sense of false security, but
> > come on, let's at least be realistic about the very real
> > advantages of Unix OSes over PC OSes in this area.
> 
> I don't see any such advantage. C2 is C2; crypto is crypto; authentication
> is authentication; vigilance is vigilance.
> 

C2 is only a standard for user permissions and access tracking .. it is
NOT security. Same goes for crypto.. I'm very sick of people telling me
they can't be "hacked" because they have "encryption"

Unix and clones tend to be more secure not because of some whiz bang
buzzword compliant toy but because on the whole it's designers have tended
to look at *why* a given hack was done or *why* a given worm spread and
chased the problem instead patching the current bug and relying on band
aid software that attempts to track a given problem based on it's
signature.  

I'm honestly surprised more exploits aren't polymorphic for the express
purpose of evading the anti virus programs.

patches and AV -vs- buffer overflow detecting libraries and compilers not
to mention the principal of least privilege.

	Gerhard

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

