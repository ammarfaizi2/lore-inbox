Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264992AbTAWHt4>; Thu, 23 Jan 2003 02:49:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265037AbTAWHt4>; Thu, 23 Jan 2003 02:49:56 -0500
Received: from angband.namesys.com ([212.16.7.85]:51335 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S264992AbTAWHtz>; Thu, 23 Jan 2003 02:49:55 -0500
Date: Thu, 23 Jan 2003 10:59:04 +0300
From: Oleg Drokin <green@namesys.com>
To: Gerhard Mack <gmack@innerfire.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why isn't quota dependant on ext2?
Message-ID: <20030123105904.A11988@namesys.com>
References: <Pine.LNX.4.44.0301212046260.5472-100000@innerfire.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301212046260.5472-100000@innerfire.net>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Tue, Jan 21, 2003 at 08:47:53PM -0500, Gerhard Mack wrote:

> Anyone know why the quota menu option isn't dependant on ext2 since that's
> all it works with?

reiserfs works with this quota code too. Chris Mason working on porting the
patch from 2.4 to 2.5.

Bye,
    Oleg
