Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266982AbTAOUgs>; Wed, 15 Jan 2003 15:36:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266996AbTAOUgs>; Wed, 15 Jan 2003 15:36:48 -0500
Received: from [66.70.28.20] ([66.70.28.20]:42503 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S266982AbTAOUgr>; Wed, 15 Jan 2003 15:36:47 -0500
Date: Wed, 15 Jan 2003 21:22:54 +0100
From: DervishD <raul@pleyades.net>
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: argv0 revisited...
Message-ID: <20030115202254.GF47@DervishD>
References: <A46BBDB345A7D5118EC90002A5072C7806CACA88@orsmsx116.jf.intel.com> <20030115191942.GD47@DervishD> <b04dqu$4f5$1@ncc1701.cistron.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b04dqu$4f5$1@ncc1701.cistron.net>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Miquel :)

> Why not make that INIT=/what/ever, then make this /sbin/init:

    I cannot force the users to do that :(( I think that I could
hardcode the name in the binary. The problem with this is that the
user may move around the binary afterwards...

    I can't find a way to get the on-disk name from the core image
:(( Uff, this is getting way complicated, just for a pretty printing
of the proc titles.

    Thanks for the suggestion, anyway :)) You're great.

    Raúl

