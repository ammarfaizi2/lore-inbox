Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285352AbSALPqC>; Sat, 12 Jan 2002 10:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285498AbSALPpn>; Sat, 12 Jan 2002 10:45:43 -0500
Received: from ns.suse.de ([213.95.15.193]:13319 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S285352AbSALPpb>;
	Sat, 12 Jan 2002 10:45:31 -0500
Date: Sat, 12 Jan 2002 16:45:30 +0100 (CET)
From: Dave Jones <davej@suse.de>
To: <hachi@kuiki.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: netlink sockets in 2.4.17
In-Reply-To: <20020112153510.GB22133@ryoko.kuiki.net>
Message-ID: <Pine.LNX.4.33.0201121643370.7982-100000@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Jan 2002 hachi@kuiki.net wrote:

> My query is this, when and why were netlink sockets removed from 2.4,

They are still there, just the config option is removed.

> and why was this not included in a Changelog at any point?

Probably comes under the incredibly terse..

- Networking updates                (David S. Miller)

in the 2.4.17 changelog.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs

