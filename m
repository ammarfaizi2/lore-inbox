Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293439AbSCKGlL>; Mon, 11 Mar 2002 01:41:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293628AbSCKGlB>; Mon, 11 Mar 2002 01:41:01 -0500
Received: from angband.namesys.com ([212.16.7.85]:61838 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S293439AbSCKGkv>; Mon, 11 Mar 2002 01:40:51 -0500
Date: Mon, 11 Mar 2002 09:40:50 +0300
From: Oleg Drokin <green@namesys.com>
To: system_lists@nullzone.org
Cc: Edward Shushkin <edward@namesys.com>, linux-kernel@vger.kernel.org,
        reiserfs-list@namesys.com
Subject: Re: [reiserfs-list] Opss! on 2.5.6 with ReiserFS
Message-ID: <20020311094050.A24782@namesys.com>
In-Reply-To: <5.1.0.14.2.20020310165035.00caf5c0@192.168.2.131> <5.1.0.14.2.20020310193611.00caf1f8@192.168.2.131>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.1.0.14.2.20020310193611.00caf1f8@192.168.2.131>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Sun, Mar 10, 2002 at 07:37:22PM +0100, system_lists@nullzone.org wrote:
> I'll apply and let me inform u about result ( just like a beta-tester )

   Can we also ask you to decode your oopses
   (as described in /usr/src/linux/Documentation/oops-tracing.txt)
   This is absolute requirement if you want unknown bugs you are hitting to
   be resolved.
   Luckily this bug was already known, so we was able to provide a patch
   without the decoded oops, but this is not always the case.

Bye,
    Oleg 
