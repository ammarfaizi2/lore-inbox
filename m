Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263257AbRFWXdq>; Sat, 23 Jun 2001 19:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263329AbRFWXdh>; Sat, 23 Jun 2001 19:33:37 -0400
Received: from 216-60-128-137.ati.utexas.edu ([216.60.128.137]:49555 "HELO
	tsunami.webofficenow.com") by vger.kernel.org with SMTP
	id <S263333AbRFWXdY>; Sat, 23 Jun 2001 19:33:24 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@webofficenow.com>
Reply-To: landley@webofficenow.com
To: "Mike Jagdis" <mjagdis@kokuacom.com>,
        "Alan Chandler" <alan@chandlerfamily.org.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Microsoft and Xenix.
Date: Sat, 23 Jun 2001 13:11:33 -0400
X-Mailer: KMail [version 1.2]
In-Reply-To: <LPBBLLNMNCOEDEJFALHPEEJBGNAA.mjagdis@kokuacom.com>
In-Reply-To: <LPBBLLNMNCOEDEJFALHPEEJBGNAA.mjagdis@kokuacom.com>
MIME-Version: 1.0
Message-Id: <01062313113305.00696@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 23 June 2001 13:57, Mike Jagdis wrote:
> > I hope the following adds a more direct perspective on this, as I
> > was a user at the time.
>
> I was _almost_ at university :-). However I do have a first edition
> of the IBM Xenix Software Development Guide from december 1984. It has
> '84 IBM copyright and '83 MS copyright. The SCO stuff I have goes back
> to '83 - MS copyrights on it go back to '81 but that's probably just
> the compiler and DOS compatibility.

Ooh!  Ooh!  I don't suppose I could borrow that?  (Hmm...  Driving to london 
isn't quite something my car's up to.  For one thing, there's no gas stations 
in the middle of the atlantic.)

The copyright dates back to when they shipped it.  I believe Microsoft's 
license with AT&T was signed in 1979 and actual work started in 1980, but 
that's in a different notebook...

>   Basically Xenix was the first MS/IBM attempt at a "real OS" for the
> PC. MS realised that multiuser/multitasking was less important than
> colour graphics for PC owners and decided to pull out of the Xenix
> business. IBM licensed it under their name to keep their desktop computer
> concept alive while the Xenix team emerged from the shake out to form SCO.

Don't make the mistake of treating IBM -OR- Microsoft as a monolithic entity. 
 IBM had a dozen departments constantly at war with each other: Unix had its 
pockets of supporters at IBM, some of whom did AIX.

At Microsoft, Paul Allen was the bix Unix fan.  Gates was indifferent to it, 
and was far more interested in the Xerox Parc perspective.

Both Bell Labs and Xerox Parc totally revolutionized computing.  Bell Labs 
worked from the inside out, how the machine works and what programmers can 
get it to do.  Multitasking, hierarchical filesystem, block and character 
device drivers, streams, pipes, etc.  Xerox Parc worked from the outside in, 
how the user interacts with the computer and what they experience.  Wysiwyg 
printing, Windows and Icons and Mice in a GUI.  (Xerox also did object 
oriented programming, and networking which was related to both the user and 
system level.  Then again Unix spun out of porting a flight simulator to the 
PDP 7.  It's not QUITE that black and white...)

In any case, gates was on the Xerox side and Allen was on the BTL side.  When 
Allen left microsoft, Xenix followed soon after.  (First SCO was "helping", 
then over the next few years the whole thing was gradually dumped on them and 
the umbilical severed.)

Remember, Xenix hadn't made much of a splash in the PC world before 1984 
because the PC simply didn't have the power to run it.  YOU try doing 
anything useful with Unix in -LESS- than 512k of ram.  That doesn't mean it 
wasn't having a big impact behind the scenes at Microsoft.  (Similarly, 
windowing interfaces were Jobs's passion for 4 or 5 years before the 
macintosh launch, whether or not Apple's revenues or customers even knew 
about it.)

Rob

