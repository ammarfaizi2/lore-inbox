Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263974AbUDFTXB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 15:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263978AbUDFTXB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 15:23:01 -0400
Received: from pra68-d23.gd.dial-up.cz ([193.85.68.23]:7810 "EHLO
	penguin.localdomain") by vger.kernel.org with ESMTP id S263974AbUDFTW5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 15:22:57 -0400
Date: Tue, 6 Apr 2004 21:22:19 +0200
To: linux-kernel@vger.kernel.org
Cc: sam@ravnborg.org, mru@kth.se
Subject: Re: menuconfig and UTF-8
Message-ID: <20040406192219.GA5938@penguin.localdomain>
Mail-Followup-To: linux-kernel@vger.kernel.org, sam@ravnborg.org,
	mru@kth.se
References: <20040404122426.GA16383@penguin.localdomain> <20040405212148.GA2387@mars.ravnborg.org> <20040406184000.GB3770@penguin.localdomain> <yw1xfzbhnde8.fsf@kth.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="A6N2fC+uXW/VQSAv"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yw1xfzbhnde8.fsf@kth.se>
User-Agent: Mutt/1.5.5.1+cvs20040105i
From: sebek64@post.cz (Marcel Sebek)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Apr 06, 2004 at 08:56:47PM +0200, Måns Rullgård wrote:
> sebek64@post.cz (Marcel Sebek) writes:
> 
> > I cannot get screenshot from console because I don't use framebuffer
> > and in xterm it works correctly (don't know why).
> 
> cat /dev/vcsX
> 
> 

Thanks.  I've attached both correct and incorrect screenshots.

-- 
Marcel Sebek
jabber: sebek@jabber.cz                     ICQ: 279852819
linux user number: 307850                 GPG ID: 5F88735E
GPG FP: 0F01 BAB8 3148 94DB B95D  1FCA 8B63 CA06 5F88 735E


--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=screenshot_good
Content-Transfer-Encoding: quoted-printable

 Linux Kernel v2.6.5 Configuration                                         =
      ---------------------------------------------------------------------=
---------   +---------------------- Linux Kernel Configuration ------------=
-----------+     |  Arrow keys navigate the menu.  <Enter> selects submenus=
 --->.          |     |  Highlighted letters are hotkeys.  Pressing <Y> inc=
ludes, <N> excludes, |     |  <M> modularizes features.  Press <Esc><Esc> t=
o exit, <?> for Help.     |     |  Legend: [*] built-in  [ ] excluded  <M> =
module  < > module capable     |     | +-----------------------------------=
----------------------------------+ |     | |            Code maturity leve=
l options  --->                        | |     | |            General setup=
  --->                                      | |     | |            Loadable=
 module support  --->                            | |     | |            Pro=
cessor type and features  --->                        | |     | |          =
  Power management options (ACPI, APM)  --->               | |     | |     =
       Bus options (PCI, PCMCIA, EISA, MCA, ISA)  --->          | |     | |=
            Executable file formats  --->                            | |   =
  | |            Device Drivers  --->                                     |=
 |     | |            File systems  --->                                   =
    | |     | |            Profiling support  --->                         =
         | |     | |            Kernel hacking  --->                       =
              | |     | +--------v(+)--------------------------------------=
-------------------+ |     +-----------------------------------------------=
--------------------------+     |                    <Select>    < Exit >  =
  < Help >                     |     +-------------------------------------=
------------------------------------+                                      =
                                                                           =
                                                 =20
--A6N2fC+uXW/VQSAv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=screenshot_bad
Content-Transfer-Encoding: quoted-printable

 Linux Kernel v2.6.5 Configuration                                         =
                                                                           =
             Linux Kernel Configuration                                    =
                   Arrow keys navigate the menu.  <Enter> selects submenus =
--->.                   Highlighted letters are hotkeys.  Pressing <Y> incl=
udes, <N> excludes,          <M> modularizes features.  Press <Esc><Esc> to=
 exit, <?> for Help.              Legend: [*] built-in  [ ] excluded  <M> m=
odule  < > module capable                                                  =
                                                         Code maturity leve=
l options  --->                                             General setup  =
--->                                                             Loadable m=
odule support  --->                                                   Proce=
ssor type and features  --->                                               =
Power management options (ACPI, APM)  --->                                 =
     Bus options (PCI, PCMCIA, EISA, MCA, ISA)  --->                       =
          Executable file formats  --->                                    =
               Device Drivers  --->                                        =
                    File systems  --->                                     =
                         Profiling support  --->                           =
                              Kernel hacking  --->                         =
                       (+)                                                 =
                                                                           =
                                                     <Select>    < Exit >  =
  < Help >                                                                 =
                                                                           =
                                                                           =
                                                 =20
--A6N2fC+uXW/VQSAv--
