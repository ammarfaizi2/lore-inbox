Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265687AbTCEMhN>; Wed, 5 Mar 2003 07:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265947AbTCEMhN>; Wed, 5 Mar 2003 07:37:13 -0500
Received: from blackbird.intercode.com.au ([203.32.101.10]:14609 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id <S265687AbTCEMhN>; Wed, 5 Mar 2003 07:37:13 -0500
Date: Wed, 5 Mar 2003 23:47:03 +1100 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Andreas Jellinghaus <aj@dungeon.inka.de>
cc: mit_warlord@users.sourceforge.net, <HOWTO@ds9a.nl>,
       <linux-kernel@vger.kernel.org>
Subject: Re: ipsec-tools 0.1 + kernel 2.5.64
In-Reply-To: <1046863752.441.7.camel@simulacron>
Message-ID: <Pine.LNX.4.44.0303052346220.22726-100000@blackbird.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Mar 2003, Andreas Jellinghaus wrote:

> But: don't "setkey -DP" while racoon is running, it crashes
> my machine. Sorry, could not get any details.

Please apply the patch in this message:
http://marc.theaimsgroup.com/?l=linux-netdev&m=104669387317759&w=2


- James
-- 
James Morris
<jmorris@intercode.com.au>


