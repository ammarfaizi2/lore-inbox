Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288544AbSANSiw>; Mon, 14 Jan 2002 13:38:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288756AbSANSin>; Mon, 14 Jan 2002 13:38:43 -0500
Received: from ns.suse.de ([213.95.15.193]:27396 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S288544AbSANSi2>;
	Mon, 14 Jan 2002 13:38:28 -0500
Date: Mon, 14 Jan 2002 19:38:24 +0100
From: Dave Jones <davej@suse.de>
To: "Eric S. Raymond" <esr@thyrsus.com>, Eli Carter <eli.carter@inet.com>,
        "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Aunt Tillie builds a kernel (was Re: ISA hardware discovery -- the elegant solution)
Message-ID: <20020114193823.H15139@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	"Eric S. Raymond" <esr@thyrsus.com>,
	Eli Carter <eli.carter@inet.com>,
	"Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <F50839283B51D211BC300008C7A4D63F0C10759D@eukgunt002.uk.eu.ericsson.se> <20020114111141.A14332@thyrsus.com> <3C430E89.E65DCEDC@inet.com> <20020114125228.B14747@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020114125228.B14747@thyrsus.com>; from esr@thyrsus.com on Mon, Jan 14, 2002 at 12:52:28PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 14, 2002 at 12:52:28PM -0500, Eric S. Raymond wrote:
 > She complains of occasional lockups, and that she gets skips when
 > playing her Guy Lombardo MP3s.  Melvin says, over the phone: "Yup,
 > that version had some VM problems.  And you need the low-latency stuff
 > that went in three releases ago.

 ... and the 200 patches that the vendor added that she's become
 so used to just being there...

 > Just click on the 'kernel update' icon on your desktop."

 *sigh*, and the package updater to get a new kernel for $distro
 is insufficient because ?
 distro kernel update has the following advantages.
 - Comes complete with the 200 patches already applied.
 - Is _tested_ by $distrovendor.
 - If it screws up, and Aunt Tillie shelled out for support
   (which of course, she did being the 'needing support' type)
   $distrovendor will help. Ringing support and saying "Melvin
   told me to install a new kernel, and now my box doesn't boot"
   may not be a supportable scenario for all vendors.
 
 > So why doesn't she use Red Hat or Mandrake's RPM update?  Maybe she's
 > running something else.

 Red Hat & Mandrake are not the only distros with online update,
 in fact, it's probably considered a must-have feature for most
 distros these days.

 > (You ain't going to tell me Aunt Tillie is ready
 > for Debian apt-get, either.)

 Wait a minute. Not ready for 'apt-get', but ready to build & run a
 kernel made up of a collection of random patches on Melvin's say-so ?
 
 > Maybe she wants a kernel that's compiled
 > for her AMD Athlon K6 rather than a 386.
 
 Various distro vendors update facilities give you this option.
 
 > OK, so she doesn't know what processor she has
 
 Some even autodetect.
 
 > We have the technology to do all of this now;
 
 Indeed. It's called YaST, Red Carpet, Mandrake Update, apt-get,
 apt-rpm, and a plethora of other such tools.
 
 > It takes a different way of thinking than most hackers are used to.

 Yup. One where reinventing the wheel seems appropriate.

 > We're proud of our mad programming skillz and our ability to wrestle
 > with arcana.  That pride isn't a bad thing -- except when it gets in
 > the way of designing systems that Aunt Tillie can use.

 The systems are designed, and the punchline is, that they work,
 and they're being used out there today.

 Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
