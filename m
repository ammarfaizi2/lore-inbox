Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291401AbSCOLun>; Fri, 15 Mar 2002 06:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291394AbSCOLud>; Fri, 15 Mar 2002 06:50:33 -0500
Received: from mailrelay1.lrz-muenchen.de ([129.187.254.101]:58714 "EHLO
	mailrelay1.lrz-muenchen.de") by vger.kernel.org with ESMTP
	id <S291372AbSCOLuW>; Fri, 15 Mar 2002 06:50:22 -0500
Date: Fri, 15 Mar 2002 12:50:12 +0100 (CET)
From: Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
To: Alexander Viro <viro@math.psu.edu>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jonathan Barker <jbarker@ebi.ac.uk>,
        <linux-kernel@vger.kernel.org>
Subject: Re: VFS mediator?
In-Reply-To: <Pine.GSO.4.21.0203141825070.329-100000@weyl.math.psu.edu>
Message-Id: <Pine.LNX.4.44.0203151245510.19029-100000@phobos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Mar 2002, Alexander Viro wrote:

> 	* NFS (v2,v3):  Portable.  And that's the only good thing to say
> about it - it's stateless, it has messy semantics all over the place and
> implementing userland server requires a lot of glue.

Well, you can compile the example lines from the RFC out of the box, you
just need to implement the actual RPC functions.

> 	Sane projects: toolkit for light-weight NFS servers;

This is what I have.

   Simon

-- 
GPG public key available from http://phobos.fs.tum.de/pgp/Simon.Richter.asc
 Fingerprint: 040E B5F7 84F1 4FBC CEAD  ADC6 18A0 CC8D 5706 A4B4
Hi! I'm a .signature virus! Copy me into your ~/.signature to help me spread!

