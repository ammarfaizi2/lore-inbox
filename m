Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316883AbSHZPcO>; Mon, 26 Aug 2002 11:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316542AbSHZPcO>; Mon, 26 Aug 2002 11:32:14 -0400
Received: from cmailm2.svr.pol.co.uk ([195.92.193.210]:45071 "EHLO
	cmailm2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S316883AbSHZPcN>; Mon, 26 Aug 2002 11:32:13 -0400
Date: Mon, 26 Aug 2002 16:32:05 +0100
From: Phil Jackson <philj@runbox.com>
To: linux-kernel@vger.kernel.org
Subject: Re: I have a question about packages of programs
Message-ID: <20020826153205.GA1212@slacker.slacker>
Reply-To: philj@runbox.com
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <3D69AA46.52A2E895@sccoast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D69AA46.52A2E895@sccoast.net>
User-Agent: Mutt/1.4i
X-BadReturnPath: phil@slacker.slacker rewritten as philj@runbox.com
  using "Reply-To" header
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 26, 2002 at 12:10:47AM -0400, John D. Coleman wrote:
 
> Because my first project is going to be a major
> overhaul of the make and/or automake programs. That ./configure
> --prefix=whatever -- src=here command-line-only-interface has got to go.

If it's going to be your first project then you going to have to learn
how to use the autotools before you "overhaul" them, the trouble is
the more you use them the more you'll realise they don't need
overhauling. Catch 22.

Phil
