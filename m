Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266292AbTB0T0c>; Thu, 27 Feb 2003 14:26:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266367AbTB0T0b>; Thu, 27 Feb 2003 14:26:31 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:40452 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S266292AbTB0T0b>; Thu, 27 Feb 2003 14:26:31 -0500
Date: Thu, 27 Feb 2003 14:35:37 -0500
From: Ben Collins <bcollins@debian.org>
To: ajoshi@kernel.crashing.org
Cc: Adrian Bunk <bunk@fs.tum.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, trond.myklebust@fys.uio.no
Subject: Re: Linux 2.4.21-pre5
Message-ID: <20030227193537.GK21100@phunnypharm.org>
References: <20030227124002.GA21100@phunnypharm.org> <Pine.LNX.4.10.10302271321001.2477-100000@gate.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10302271321001.2477-100000@gate.crashing.org>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 27, 2003 at 01:22:25PM -0600, ajoshi@kernel.crashing.org wrote:
> 
> 
> Just for the record, the patch I sent to Marcelo did _NOT_ include any
> 1394 hunks in it.  Marcelo must have accidently mixed mine up with some
> old 1394 tree.

That's sort of what I figured.

Marcelo, do you want me to send you a complete patch against -pre5
reverting all this junk, or do you want to revert it and then accept a
new patch?

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
Deqo       - http://www.deqo.com/
