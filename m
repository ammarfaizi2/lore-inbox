Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262519AbTHZDsp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 23:48:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262524AbTHZDso
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 23:48:44 -0400
Received: from www.13thfloor.at ([212.16.59.250]:43213 "EHLO www.13thfloor.at")
	by vger.kernel.org with ESMTP id S262519AbTHZDsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 23:48:43 -0400
Date: Tue, 26 Aug 2003 05:48:53 +0200
From: Herbert =?iso-8859-1?Q?P=F6tzl?= <herbert@13thfloor.at>
To: Norbert Preining <preining@logic.at>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22 tar ball misses drivers/scsi/aic79xx
Message-ID: <20030826034853.GD20506@www.13thfloor.at>
Reply-To: herbert@13thfloor.at
Mail-Followup-To: Norbert Preining <preining@logic.at>,
	linux-kernel@vger.kernel.org
References: <20030825212238.GA27385@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030825212238.GA27385@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 25, 2003 at 11:22:38PM +0200, Norbert Preining wrote:
> Hi!
> 
> I compared a `patched up' version (all the way through the pre and rc
> stages) with a tar ball from www.at.kernel.org, and the later is missing
> the whole drivers/scsi/aic79xx directory.

where the former probably contains a single empty directory
(aicasm), which was left over, because patch doesn't remove 
empty directories ...

the stuff got moved into aic7xxx ...

best,
Herbert

> Best wishes
> 
> Norbert
> 
> -------------------------------------------------------------------------------
> Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
> gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
> -------------------------------------------------------------------------------
> POGES (pl.n.)
> The lumps of dry powder that remain after cooking a packet soup.
> 			--- Douglas Adams, The Meaning of Liff
> -
