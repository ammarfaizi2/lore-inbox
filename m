Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267908AbTAMOV3>; Mon, 13 Jan 2003 09:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267918AbTAMOV3>; Mon, 13 Jan 2003 09:21:29 -0500
Received: from poup.poupinou.org ([195.101.94.96]:313 "EHLO poup.poupinou.org")
	by vger.kernel.org with ESMTP id <S267908AbTAMOV2>;
	Mon, 13 Jan 2003 09:21:28 -0500
Date: Mon, 13 Jan 2003 15:30:16 +0100
To: Jeffrey Ross <jeff@xyzzy.bubble.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ACPI errors (2.4.21-pre3-ac4)
Message-ID: <20030113143016.GA12522@poup.poupinou.org>
References: <3E21DD72.7080903@xyzzy.bubble.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E21DD72.7080903@xyzzy.bubble.org>
User-Agent: Mutt/1.4i
From: Ducrot Bruno <poup@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 12, 2003 at 04:26:10PM -0500, Jeffrey Ross wrote:
> This existed with the earlier kernels as well, on boot up I get the 
> following when I enable ACPI:
> 
> early in the dmesg output:
> 

AFAICT, ACPI in vanilla and ac series is too old.  Try a patch upgrade from
sf.net/projects/acpi/

The problem you reported is well known and was fixed a long time ago.

Cheers,

-- 
Ducrot Bruno
http://www.poupinou.org        Page profaissionelle
http://toto.tu-me-saoules.com  Haume page
