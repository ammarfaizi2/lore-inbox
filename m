Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286322AbRLTSpn>; Thu, 20 Dec 2001 13:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286327AbRLTSp3>; Thu, 20 Dec 2001 13:45:29 -0500
Received: from schwerin.p4.net ([195.98.200.5]:26174 "EHLO schwerin.p4.net")
	by vger.kernel.org with ESMTP id <S286322AbRLTSpX>;
	Thu, 20 Dec 2001 13:45:23 -0500
Message-ID: <3C223255.5020107@p4all.de>
Date: Thu, 20 Dec 2001 19:47:49 +0100
From: Michael Dunsky <michael.dunsky@p4all.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: de, en
MIME-Version: 1.0
To: Matt Bernstein <matt@theBachChoir.org.uk>
CC: Steven Cole <scole@lanl.gov>, esr@thyrsus.com,
        linux-kernel@vger.kernel.org
Subject: Re: Changing KB, MB, and GB to KiB, MiB, and GiB in Configure.help.
In-Reply-To: <Pine.LNX.4.43.0112201810340.16545-100000@nick.dcs.qmul.ac.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

You are close - he uses "MiB" as short for "mebi" - Mega-binary.
Don't laugh - this is official! It's exactly for what you said:

What is 1 MB?
1.000.000 Byte
or
1.048.576 Byte


For a short reading I recommend this:

http://physics.nist.gov/cuu/Units/binary.html


ciao

Michael


Matt Bernstein wrote:

  > I believe that the main purpose of documentation, help etc is to get the
  > information across in a way that is most easily understood, ie that
  > minimises the number of support questions.. ..and everyone surely knows
  > what GB, MB and KB stand for. So let's leave it at that. Where's the "i"
  > in "megabyte" ? Or is 1MiB 1000000 bytes, rather than 1048576?
  >
  > It's confusing enough with the 10 "Mb" networking / 1.44 "MB" floppy
  > distinction already..
  >
  > At 11:02 -0700 Steven Cole wrote:
  >
  >
  >>Now, granted that this is the "standard", should there be some
discussion related to this
  >>change, or is everyone comfortable with this?  It certainly made me
do a double take.
  >>
  >>Here is a snippet from the diff between versions 2.75 and 2.76 of
Configure.help:
  >>
  >>@@ -344,8 +344,8 @@
  >>  If you are compiling a kernel which will never run on a machine with
  >>  more than 960 megabytes of total physical RAM, answer "off" here
  >>  (default choice and suitable for most users). This will result in a
  >>-  "3GB/1GB" split: 3GB are mapped so that each process sees a 3GB
  >>-  virtual memory space and the remaining part of the 4GB virtual memory
  >>+  "3GiB/1GiB" split: 3GiB are mapped so that each process sees a 3GiB
  >>+  virtual memory space and the remaining part of the 4GiB virtual 
memory
  >>  space is used by the kernel to permanently map as much physical memory
  >>  as possible.
  >>
  >
  > -
  > To unsubscribe from this list: send the line "unsubscribe
linux-kernel" in
  > the body of a message to majordomo@vger.kernel.org
  > More majordomo info at  http://vger.kernel.org/majordomo-info.html
  > Please read the FAQ at  http://www.tux.org/lkml/
  >
  >





