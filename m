Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbTF1Snh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Jun 2003 14:43:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265329AbTF1Sng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Jun 2003 14:43:36 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:36746
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S265326AbTF1Snf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Jun 2003 14:43:35 -0400
Subject: Re: Dell vs. GPL
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fluke <fluke@gibson.mw.luc.edu>
Cc: linux-poweredge@dell.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0306280005000.29249-100000@gibson.mw.luc.edu>
References: <Pine.LNX.4.44.0306280005000.29249-100000@gibson.mw.luc.edu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1056826496.6295.7.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 28 Jun 2003 19:54:56 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-28 at 06:51, Fluke wrote:
>   Dell is providing binary only derived works of the Linux kernel and the 
> modutils package at ftp://ftp.dell.com/fixes/boot-floppy-rh9.tar.gz

and a patch file of the relevant diff, which btw Dell engineers actually
did a lot of work in figuring out why the serverworks stuff was a
problem and fixing most of the bug, and sent to me.

>   I contacted Dell support and recieved confirmation that Dell does not 
> intend to provide the source code to these binary works.  He explained 
> that all Dell fixes are licensed by Dell from third parties for use by 
> Dell customers in binary only form and "Dell does not intend the fixes to 
> be open source products."

Dell support are a bit random and in my experience completely clueless
when faced with anything which isnt on the script. Much like most
support people.

>   I have also tried to contact RedHat activities but based on the responce 
> that I got from Mark Webbink, I don't think RedHat is prepaired to do 
> anything about it.

Firstly they are supplying the patch in question. Secondly they are
making sure people actually get it. 

>   Is the GPL as it applies to the kernel intended to be a legal set of 
> requirements or simply a set of optional guidelines like Dell/RedHat seems 
> to be treating it?

Red Hat takes all its license compliance seriously. 

What Dell do is their business - they've given you the patch, and yes
you might want to have a discussion about getting the entire SRPM
package, but do it with the right bits of Dell, and with the FSF
perhaps. The FSF has no business attachments to muddy waters.

There are better people to raise these issues with than Dell support
personnel.

Alan

