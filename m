Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTEHQZq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 May 2003 12:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261858AbTEHQZp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 May 2003 12:25:45 -0400
Received: from h-64-105-35-101.SNVACAID.covad.net ([64.105.35.101]:3482 "EHLO
	adam.yggdrasil.com") by vger.kernel.org with ESMTP id S261851AbTEHQZn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 May 2003 12:25:43 -0400
Date: Thu, 8 May 2003 09:35:46 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
Message-Id: <200305081635.h48GZk007160@adam.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Binary firmware in the kernel - licensing issues.
Cc: simon@thekelleys.org.uk
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon Kelley wrote:

>Briefly, the arguments that binary firmware which is copied into the
>hardware by the kernel is OK are these.
[...]
>5) There are current examples in the kernel of drivers with source-free
>    binary firmware blobs going back at least to version 1.3. This means
>    that someone might have considered this before and OKed it.

	I don't know who supposedly "OKed" what in the above
sentence.

>    It also
>    means that anyone who added code to the kernel since 1.3 had
>    evidence that for Linux the interpration of this GPL grey area
>    was to allow binary firmware. It is difficult to a contributor to
>    turn around now and claim copyright infrigement by distributing their
>    work with binary firmware when the kernel already had binary firmware
>    in it when their contribution was first made.

	I addressed this previously.  The fact that nobody has
litigated this yet, does not mean that everyone accepts in.

>6) AFAIK nobody has claimed that the existing firmware blobs in Linux
>    violate their copyright on GPL-licensed kernel contributions and
>    fairly certainly nobody has pressed this in law. (Since if they
>    had it would be well-known.)

	Just so you can never truthfully make this statment again,
for the record, I believe that the existing "firmware blobs"
in Linux that do not include source infringe Yggdrasil copyrights
on GPL-licensed kernel contributions (just as I believe they
infringe many other authors' GPL-licensed contributions).


>The arguments against allowing binary firmware are these.

	Let's be clear: embedding binary firmware into a GPL'ed
work is fine if the firmware contains no additional restriction
beyond the GPL and complete source code for the firmware is
included.  I think you understand this much already, but I just
want to be clear about it.

>1) The GPL is unclear on this point.

	All three distribution options in section 3 of the version 2
of the GNU General Public License require distribution or arrangments
for distribution "machine-readable source code", and defines
"source code" as "the preferred form of the work for making
modifications to it."  That seems pretty clear to me.

	By the way, I believe the FSF has already said that
the GPL prohibits these binary blobs without source code, and
I am confident that they would testify or submit a friend of
the court brief to that effect if necessary (and I believe it
would be usable by the court for interpreting a contract under
"the four corners rule").

>2) The intention of the GPL is to allow redistribution only
>    with source.
>3) Some contributors to the kernel might want their work distributed
>    only with all source, including firmware source. These people
>    would contend that their copyright had been violated and would
>    feel aggrieved or sue for lots of money.

	A problem with legal grey areas is that they create an
environment where vendors are made to choose between breaking the
law and perhaps being caught years later or going out of business
(because all the customers preferred less and less legal vendors).
So vendors may need to litigate GPL infractions more often and earlier
to avoid the "competition for the most illegal" dilemma, even
nobody in no individually actually feels that "aggrieved" in an
emotional sense.

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Miplitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
