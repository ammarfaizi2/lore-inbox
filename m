Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265361AbTANVzl>; Tue, 14 Jan 2003 16:55:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265369AbTANVzl>; Tue, 14 Jan 2003 16:55:41 -0500
Received: from [66.70.28.20] ([66.70.28.20]:61708 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S265361AbTANVzk>; Tue, 14 Jan 2003 16:55:40 -0500
Date: Tue, 14 Jan 2003 23:04:01 +0100
From: DervishD <raul@pleyades.net>
To: Philippe Troin <phil@fifi.org>
Cc: root@chaos.analogic.com, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030114220401.GB241@DervishD>
References: <Pine.LNX.3.95.1030114140811.13496A-100000@chaos.analogic.com> <87iswrzdf1.fsf@ceramic.fifi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87iswrzdf1.fsf@ceramic.fifi.org>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Philippe :)

> You just overwrote all your arguments (argv[0] and others) and part of
> the environment.

    Oh, sh*t, you're true, and that is the problem I was afraid to
suffer from. Then, all I can do is overwrite argv[0] with a new
string whose length is less or equal than the existing one.

    Well, I suppose I must go with that limitation.

    Thanks, Philippe, for the code snipped and the explanation.

    Raúl
