Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268739AbRGZXxP>; Thu, 26 Jul 2001 19:53:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268737AbRGZXxG>; Thu, 26 Jul 2001 19:53:06 -0400
Received: from stm.lbl.gov ([131.243.16.51]:64264 "EHLO stm.lbl.gov")
	by vger.kernel.org with ESMTP id <S268736AbRGZXwv>;
	Thu, 26 Jul 2001 19:52:51 -0400
Date: Thu, 26 Jul 2001 16:52:55 -0700
From: David Schleef <ds@schleef.org>
To: linux-kernel@vger.kernel.org
Subject: ANNOUNCE: Comedi-0.7.60
Message-ID: <20010726165254.A3696@stm.lbl.gov>
Reply-To: David Schleef <ds@schleef.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing


    COMEDI
    The Linux Control and Measurement Device Interface
    David Schleef <ds@schleef.org>


* Comedi-0.7.60:

The latest version of Comedi, 0.7.60, is now available at
ftp://stm.lbl.gov/pub/comedi/.

* About Comedi:

Comedi is a collection of drivers for data acquisition hardware.
These drivers work with Linux, and also with Linux combined with
the real-time extensions RTAI and RTLinux.  The Comedi core, which
ties all the driver together, allows applications to be written
that are completely hardware independent.

Comedi supports a variety of data acquisition hardware; an
incomplete list can be found in Documentation/comedi/drivers.txt.

This distribution contains just the Comedi kernel modules.  You will
almost certainly also want to download Comedilib, which is a user
space library, a few utilities, and some example programs.

* More Information:

Comedi also has a web page, at http://stm.lbl.gov/comedi.  New versions
of comedi can be found on the ftp site ftp://stm.lbl.gov/pub/comedi.

Often bugfixes and new features that are not in the current release
can be found in the CVS repository.  Instructions for anonymous CVS
access to the Comedi and Comedilib repositories are found at
http://oss.lineo.com/cvs_anon.html.

Comedi may be freely distibuted and modified in accordance with the
GNU General Public License.

The person behind all this misspelled humor is David Schleef
<ds@schleef.org>.

