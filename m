Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315720AbSGJMbs>; Wed, 10 Jul 2002 08:31:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSGJMbr>; Wed, 10 Jul 2002 08:31:47 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:9196 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S315720AbSGJMbo>; Wed, 10 Jul 2002 08:31:44 -0400
Date: Wed, 10 Jul 2002 14:34:21 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Thomas Tonino <ttonino@users.sourceforge.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: Terrible VM in 2.4.11+?
In-Reply-To: <3D2BF3CC.3040409@users.sf.net>
Message-ID: <Pine.NEB.4.44.0207101429410.24665-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 Jul 2002, Thomas Tonino wrote:

>...
> So we're going with 2.4.19-pre9-aa2 for now. I don't yet understand the
> -aa series, for example how 2.4.19-rc1-aa1 would relate to
> 2.4.19-pre9-aa2, so I'm a bit wary of just upgrading in the -aa series
> right now.

The -aa patches are usually against the most recent 2.4 kernel (they are
usually only available against one specific kernel), IOW the following are
increasing version numbers:

2.4.18-aa1
2.4.18-pre8-aa1
2.4.19-pre9-aa1
2.4.19-pre9-aa2
2.4.19-rc1-aa1  (rc = "release candidate")
2.4.19-aa1
2.4.20-pre1-aa1

> Thomas

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox


