Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266243AbTAOLkE>; Wed, 15 Jan 2003 06:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266270AbTAOLkD>; Wed, 15 Jan 2003 06:40:03 -0500
Received: from [66.70.28.20] ([66.70.28.20]:14098 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266243AbTAOLi6>; Wed, 15 Jan 2003 06:38:58 -0500
Date: Wed, 15 Jan 2003 12:35:33 +0100
From: DervishD <raul@pleyades.net>
To: Bob Miller <rem@osdl.org>
Cc: Philippe Troin <phil@fifi.org>, root@chaos.analogic.com,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030115113533.GC66@DervishD>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org> <20030114220401.GB241@DervishD> <20030114230418.GB4603@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030114230418.GB4603@doc.pdx.osdl.net>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Bob :)

> Or you can copy your all your args and env to a temporary place and
> then re-build your args and env with the new argv[0] in it's place.

    Yes, this is a good solution, too. The problem with all solutions
is that they involve a good bunch of code for a thing that doesn't
deserve it ;))

    Moreover, since I must preserve the environment and I'm pretty
sure that there is no arg except argv[0], I end up with the same
problem. The user may install this bit of crap under name '/i', for
example, and then I have only two characters for the new name :((

    Thanks for your help :)

    Raúl
