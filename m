Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264294AbTK2RQj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Nov 2003 12:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264361AbTK2RQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Nov 2003 12:16:39 -0500
Received: from mxsf17.cluster1.charter.net ([209.225.28.217]:16133 "EHLO
	mxsf17.cluster1.charter.net") by vger.kernel.org with ESMTP
	id S264294AbTK2RQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Nov 2003 12:16:33 -0500
Date: Sat, 29 Nov 2003 12:15:55 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: NForce2 pseudoscience stability testing (2.6.0-test11)
Message-ID: <20031129171555.GA7235@forming>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <OF6617181D.A93B9D63-ON80256DEC.004D7534-80256DEC.0053A823@uk.neceur.com> <200311281646.40171.s0348365@sms.ed.ac.uk> <frodoid.frodo.87zneg8ipo.fsf@usenet.frodoid.org> <20031129025500.GA5611@forming> <frodoid.frodo.87he0njfsr.fsf@usenet.frodoid.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <frodoid.frodo.87he0njfsr.fsf@usenet.frodoid.org>
X-Editor: GNU Emacs 21.1
X-Operating-System: Debian GNU/Linux 2.6.0-test9-mm3 i686
X-Uptime: 12:12:12 up  8:13,  2 users,  load average: 1.24, 1.05, 1.02
User-Agent: Mutt/1.5.4i
From: Josh McKinney <forming@charter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On approximately Sat, Nov 29, 2003 at 05:33:08PM +0100, Julien Oster wrote:
> Josh McKinney <forming@charter.net> writes:
> 
> Hello Josh,
> 
> > I have also been using a A7N8X deluxe and saw lockups when I first
> > recieved the board.  Booting with noapic nolapic solved the problems.
> > Later after reading some threads about it I decided to add some stuff to
> > a bugzilla that someone else already filed.  After doing this I decided
> > to try to crash it like it used to to with apic and lapic but it DID NOT
> > CRASH!  This may be due to an updated BIOS, I am using the 1007 Uber
> > BIOS, or some updates with the kernel, but I am running 2.6.0-test9-mm3
> > rock solid with ACPI, APIC, and local APIC.
> 
> Oh! That sounds nice. I also run the latest 1007 BIOS, but that
> doesn't help at all. In crontrary, I almost have the impression that
> the lockups got worse, but that may be just subjective. But what do
> you mean with "1007 Uber BIOS"? What is this "Uber"? Is that a special
> BIOS Version?
> 

I should have given more info.  It is a custom made BIOS made by a guy
at nforcershq.com

http://homepage.ntlworld.com/michael.mcclay/ 

It is strange to me that it doesn't crash anymore either.  I am going to
boot test11 when I get the chance later today and will see if it still works.

-- 
Josh McKinney		     |	Webmaster: http://joshandangie.org
--------------------------------------------------------------------------
                             | They that can give up essential liberty
Linux, the choice       -o)  | to obtain a little temporary safety deserve 
of the GNU generation    /\  | neither liberty or safety. 
                        _\_v |                          -Benjamin Franklin
