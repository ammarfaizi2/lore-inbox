Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318700AbSHEQmg>; Mon, 5 Aug 2002 12:42:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318702AbSHEQmf>; Mon, 5 Aug 2002 12:42:35 -0400
Received: from tassadar.physics.auth.gr ([155.207.123.25]:31281 "EHLO
	tassadar.physics.auth.gr") by vger.kernel.org with ESMTP
	id <S318700AbSHEQmf>; Mon, 5 Aug 2002 12:42:35 -0400
Date: Mon, 5 Aug 2002 19:46:04 +0300 (EEST)
From: Dimitris Zilaskos <dzila@tassadar.physics.auth.gr>
To: Aaron Denny <euphguy86@yahoo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: ppp problem
In-Reply-To: <20020805122717.78585.qmail@web20514.mail.yahoo.com>
Message-ID: <Pine.LNX.4.44.0208051940490.4448-100000@tassadar.physics.auth.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Aug 2002, Aaron Denny wrote:

> Hi, i recently updated my kernel to 2.4.9 from 2.2.13,
> quite a large jump obviously, im in slackware 7.0, ok

  Slackware 7.x lacks /dev/ppp which is needed to do ppp with 2.4.x kernel
, I had the same problem when I moved my slack 7.0 box to 2.4 You also
need newer pppd . The steps you have to take  are in
/your-linux-source-dir/Documentation/Changes . There is a ppp section in
there . Read it and follow its instructions .

  Kind regards ,

--
=============================================================================

Dimitris Zilaskos

Department of Physics @ Aristotle Univercity of Thessaloniki , Greece
PGP key : http://tassadar.physics.auth.gr/~dzila/pgp_public_key.asc
          http://egnatia.ee.auth.gr/~dzila/pgp_public_key.asc
MD5sum  : 4f84f3f53cb046008b4abcb2a092d28d  pgp_public_key.asc
=============================================================================


