Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270214AbTHBT2u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Aug 2003 15:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270222AbTHBT2t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Aug 2003 15:28:49 -0400
Received: from holomorphy.com ([66.224.33.161]:60388 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S270214AbTHBT2t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Aug 2003 15:28:49 -0400
Date: Sat, 2 Aug 2003 12:29:57 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Diego Calleja Garc?a <diegocg@teleline.es>
Cc: herbert@13thfloor.at, seanlkml@rogers.com, linux-kernel@vger.kernel.org
Subject: Re: .config in bzImage ?
Message-ID: <20030802192957.GC32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Diego Calleja Garc?a <diegocg@teleline.es>, herbert@13thfloor.at,
	seanlkml@rogers.com, linux-kernel@vger.kernel.org
References: <093901c35924$f3040ed0$7f0a0a0a@lappy7> <20030802184932.GA12057@www.13thfloor.at> <20030802210055.556cf98e.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030802210055.556cf98e.diegocg@teleline.es>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 02, 2003 at 09:00:55PM +0200, Diego Calleja Garc?a wrote:
> There's something in -ac tree:
>   x CONFIG_IKCONFIG:

IIRC this hit current 2.6 bk recently, which probably helps _someone_
with administration (and may very well save me some reboots to get into
kernels with known .configs).


-- wli
