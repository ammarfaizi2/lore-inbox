Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284302AbRLBTpL>; Sun, 2 Dec 2001 14:45:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284303AbRLBTox>; Sun, 2 Dec 2001 14:44:53 -0500
Received: from adsl-67-36-120-14.dsl.klmzmi.ameritech.net ([67.36.120.14]:23500
	"HELO tabris.net") by vger.kernel.org with SMTP id <S284301AbRLBToq>;
	Sun, 2 Dec 2001 14:44:46 -0500
Content-Type: text/plain;
  charset="iso-8859-1"
From: Adam Schrotenboer <adam@tabris.net>
Organization: Dome-S-Isle Data
To: "victor1 torres" <camel_3@hotmail.com>
Subject: Re: Bidirectional USB Printer
Date: Sun, 2 Dec 2001 14:44:39 -0500
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <F255bsHGKFMj0LClVNp00021b11@hotmail.com>
In-Reply-To: <F255bsHGKFMj0LClVNp00021b11@hotmail.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20011202194439.672A5FB80D@tabris.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 02 December 2001 13:32, you wrote:
> I´m sorry I use Slackware-8.0 + Current
What does current mean? 2nd (and this is not a problem w/ u, but rather me) I 
know nada about Slackware, and the people I know who know about Slackware 
don't read LKML)

> And one more thing could you give me the e-mail address for the USB
> Maintainers.

Kindly, RTFM. Maintainers are listed in <kernel src>/MAINTAINERS
Also, this is not to mean that the q shouldn't be on lkml

USB PRINTER DRIVER
P:      Vojtech Pavlik
M:      vojtech@suse.cz
L:      linux-usb-users@lists.sourceforge.net
L:      linux-usb-devel@lists.sourceforge.net
S:      Supported

USB SUBSYSTEM (I think this entry is wrong, and the corrected entry is below)
P:      Johannes Erdfelt
M:      johannes@erdfelt.com
L:      linux-usb-users@lists.sourceforge.net
L:      linux-usb-devel@lists.sourceforge.net
W:      http://www.linux-usb.org
S:      Supported

USB SUBSYSTEM
P:      Greg Kroah-Hartman
M:      greg@kroah.com
M:      gregkh@us.ibm.com
L:      linux-usb-users@lists.sourceforge.net
L:      linux-usb-devel@lists.sourceforge.net
W:      http://www.linux-usb.org
S:      Supported


> Victor
>
> On Saturday 01 December 2001 12:51, victor1 torres wrote:
>  > I have a bidirectional usb printer and I was woundering how I would get
>  > that to work with user space programs and if it really is supported.
>  > When
>
> I
>
>  > load all my USB things and the printer.o it says Bidirectional USB
> > Printer
>
>  > = usblp0
>
> Doesn't sounds like a problem. Merely have to set up LPR or whatever
> printing
> subsystem is in use w/ your distribution. You never said what distribution,
> so I can't tell you what to do to configure your box. Presumably, all u
> need to do is configure whatever LPR equivalent to use /dev/usblp0 (or do a
> find for lp0 in your /dev/ directory).
>
>  > Please help.
>
> It's kind of hard when you don't tell us enough to give you a concise
> answer.
> Please help us by helping yourself in the future.
>
>  > Thanks in advance
>
> Spelling errors corrected for free
>
>
> BTW, next time try to cc: to the appropriate subsystem maintainer (in this
> case USB and/or printing/parport) not the kernel maintainer. Neither Linus
> or Marcelo need to be cc:'d for this kind of question.

-- 
tabris

   They were big and little creatures. Some were hairy with long, thin
   tails, and some had noses long as pokers. Some had bulging eyes and
   some had 20 toes. In they came -- crashing through the door, sliding
   down the chimney, crawling through the windows. They shouted and
   cried. They banged pots and pans. They twirled their tails and tapped
   their toes upon the wooden floor. He watched as the trolls gobbled the
   food and threw the plates and drank everything in sight. They
   continued to shout and scream, to scratch the walls and pound the
   floors and slap their tails upon the table. The tiny trolls were the
   worst of all. They screamed at the top of their lungs and pulled each
   others' tails.

                                                       The Brothers Grimm
