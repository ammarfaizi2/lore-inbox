Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129232AbQJ0GdF>; Fri, 27 Oct 2000 02:33:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129234AbQJ0Gcz>; Fri, 27 Oct 2000 02:32:55 -0400
Received: from vger.timpanogas.org ([207.109.151.240]:46596 "EHLO
	vger.timpanogas.org") by vger.kernel.org with ESMTP
	id <S129232AbQJ0Gcn>; Fri, 27 Oct 2000 02:32:43 -0400
Message-ID: <39F920B6.F5888F86@timpanogas.org>
Date: Fri, 27 Oct 2000 00:29:10 -0600
From: "Jeff V. Merkey" <jmerkey@timpanogas.org>
Organization: TRG, Inc.
X-Mailer: Mozilla 4.7 [en] (WinNT; I)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: NWFS Imaging/Migration tools for Linux Posted
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I have posted a very complete set of server migration/consolidation
tools for Linux at vger.timpanogas.org.  These tools include
Installshield versions for W2K, Linux, and DOS and provide a complete
set of tools that can be used to perform large-scale organization-wide
migrations of NetWare servers to Linux.  

These tools allow IT personnel to boot NetWare servers on DOS, W2K, or
Linux, and compress and archive entire volume sets of a NetWare server's
data into offline archives for migrating and consolidating NetWare
servers and moving large amounts of user data over to Linux systems.  
NDS (NetWare Directory Services) database files are preserved and stored
as well in these archives and these tools preserve all of a customer's
NDS data for review and import into 
Linux in native eDirectory formats.  

We are releasing these tools to aid Novell's Oracle customers who have
been advised by Oracle to immediately migrate to Linux from NetWare. TRG
will be posting Ute-NWFS Oct 30, 2000 (Linux on Native NWFS) along with
the NWFS patches for 2.2.17 on Monday.  The full source code for the
Imaging tools will also be posted at the time at vger.timpanogas.org.   
The inode mapping problems for NWFS are completed and ready to roll out.

All Imaging/Migration tools and related source code for W2K, Linux, and
DOS versions are released under the GPL, and are freely
redistributable.  

Jeff Merkey
CEO, TRG

P.S.

This want sent to TRG by NetWare customers using Oracle who wanted an
easy path to get from
NetWare to Linux.

Oracle cuts NetWare support

Oracle is to drop its support for Novell's NetWare in a move which
analysts say will kill off the operating system as a database
platform.  

The company unexpectedly announced last week that it would
withdraw all support for NetWare from 31 December 2001, giving users
just one year to migrate to other platforms. 

Robin Bloor, chief executive at Bloor Research, said it would be
difficult for Novell to
maintain Netware's role as a database platform without the support of
Oracle. "I believe 
that NT is a better database server than NetWare,
and the market agrees. But for those who have NetWare, it is important
to have support," he said. "We'll see if they will now move over to
Linux or NT."  

Oracle will continue to offer limited 'extended
assistance support' for its products on NetWare for another three
years, but this was described as "worthless" because it does not cover
bug fixes, certification or response time support. 

"Without error correction support, the extended assistance support is
meaningless,"
said one user.  Oracle has recommended that "customers upgrade to
other platforms as soon as possible", and is touting its own Oracle 8i
appliance as well as Linux, Sun Solaris and HP-Unix. 

A Novell spokeswoman said that the discontinuation of support was
Oracle's
decision but that Novell was helping to find migration arrangements
for its users. "Our customers are unhappy and say that Oracle is
wrong," she said. 

The announcement comes as a blow for Novell so soon after announcing the
release of its internet-based open platform, NetWare 6.  Gartner's Mike
Silver predicted last week that
investments in Novell's products and services would only be viable up
until 2004.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
