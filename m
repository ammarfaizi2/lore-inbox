Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267137AbTA0Hik>; Mon, 27 Jan 2003 02:38:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267138AbTA0Hik>; Mon, 27 Jan 2003 02:38:40 -0500
Received: from postoffice.erunway.com ([12.40.51.200]:62212 "EHLO
	mailserver.virtusa.com") by vger.kernel.org with ESMTP
	id <S267137AbTA0Hij>; Mon, 27 Jan 2003 02:38:39 -0500
Date: Mon, 27 Jan 2003 13:47:41 +0600
From: Anuradha Ratnaweera <ARatnaweera@virtusa.com>
To: DervishD <raul@pleyades.net>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Changing argv[0] under Linux.
Message-ID: <20030127074741.GA1124@aratnaweera.virtusa.com>
References: <20030114185934.GA49@DervishD>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030114185934.GA49@DervishD>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 2003-01-15 at 00:59, DervishD wrote:
>
> I want to change the argv[0] a program shows, in order 
> to be pretty-printed when issuing 'ps', 'top' or
> other commands.

Sorry about the late reply.

This is done nicely in PostgreSQL.  Check source at early
initializing parts of the postmaster.

	Anuradha

-- 

Debian GNU/Linux (kernel 2.4.20)

It may be better to be a live jackal than a dead lion, but it is better
still to be a live lion.  And usually easier.
		-- Lazarus Long

