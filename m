Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262046AbTHTQtp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 12:49:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTHTQto
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 12:49:44 -0400
Received: from d12lmsgate-2.de.ibm.com ([194.196.100.235]:4556 "EHLO
	d12lmsgate-2.de.ibm.com") by vger.kernel.org with ESMTP
	id S262046AbTHTQtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 12:49:41 -0400
Message-ID: <3F43A631.50308@zurich.ibm.com>
Date: Wed, 20 Aug 2003 18:47:45 +0200
From: Roman Pletka <rap@zurich.ibm.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020903
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Stephan von Krawczynski <skraw@ithnet.com>
CC: bloemsaa@xs4all.nl, davem@redhat.com, alan@lxorguk.ukuu.org.uk,
       willy@w.ods.org, richard@aspectgroup.co.uk, carlosev@newipnet.com,
       lamont@scriptkiddie.org, davidsen@tmr.com, marcelo@conectiva.com.br,
       netdev@oss.sgi.com, linux-net@vger.kernel.org, layes@loran.com,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4 PATCH] bugfix: ARP respond on all devices
References: <353568DCBAE06148B70767C1B1A93E625EAB58@post.pc.aspectgroup.co.uk>	<20030819145403.GA3407@alpha.home.local>	<20030819170751.2b92ba2e.skraw@ithnet.com>	<20030819085717.56046afd.davem@redhat.com>	<20030819185219.116fd259.skraw@ithnet.com>	<3F43891E.9060204@zurich.ibm.com> <20030820175504.07658147.skraw@ithnet.com>
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan von Krawczynski wrote:
 >On Wed, 20 Aug 2003 16:43:42 +0200
 >Roman Pletka <rap@zurich.ibm.com> wrote:
 >
 >
 >>Please read carefully what you have quoted:
 >>It says: *An* implementation... and then goes on with a citation of RFC 826.
 >>A simple citation does not make a valid standard yet. It just refers to it
 >>as an example for this specific issue. That's all.
 >
 >
 >Sorry, but my reading is this "An implementation of the ( Address Resolution
 >Protocol (ARP) [LINK:2] ) ..."
 >Do you understand what I mean?
 >
 >If you insist on RFC-826 being only one of several (possible) ARP
 >implementations, can you then please name an RFC where ARP as a protocol is
 >clearly defined? I mean there must be one, or not?

This is not the point. As has already been mentioned some days ago by davem
RFC 826 explicitely states at the beginning that it is not the specification
of an Internet Standard and thats what I meant.

So let's stop spinning round on this.

-- Roman


