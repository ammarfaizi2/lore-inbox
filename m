Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261722AbTCKX2W>; Tue, 11 Mar 2003 18:28:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbTCKX2W>; Tue, 11 Mar 2003 18:28:22 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:38814 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S261722AbTCKX2U>; Tue, 11 Mar 2003 18:28:20 -0500
Date: Tue, 11 Mar 2003 20:39:05 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Ben Collins <bcollins@debian.org>
Cc: ajoshi@kernel.crashing.org, Adrian Bunk <bunk@fs.tum.de>,
       lkml <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: Re: Linux 2.4.21-pre5
In-Reply-To: <20030227193537.GK21100@phunnypharm.org>
Message-ID: <Pine.LNX.4.53L.0303112038390.4591@freak.distro.conectiva>
References: <20030227124002.GA21100@phunnypharm.org>
 <Pine.LNX.4.10.10302271321001.2477-100000@gate.crashing.org>
 <20030227193537.GK21100@phunnypharm.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 27 Feb 2003, Ben Collins wrote:

> On Thu, Feb 27, 2003 at 01:22:25PM -0600, ajoshi@kernel.crashing.org wrote:
> >
> >
> > Just for the record, the patch I sent to Marcelo did _NOT_ include any
> > 1394 hunks in it.  Marcelo must have accidently mixed mine up with some
> > old 1394 tree.
>
> That's sort of what I figured.
>
> Marcelo, do you want me to send you a complete patch against -pre5
> reverting all this junk, or do you want to revert it and then accept a
> new patch?

-BK is fixed now by your latest patches. Thanks.
