Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261205AbTBJLky>; Mon, 10 Feb 2003 06:40:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267403AbTBJLky>; Mon, 10 Feb 2003 06:40:54 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:62731 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261205AbTBJLkt>; Mon, 10 Feb 2003 06:40:49 -0500
Date: Mon, 10 Feb 2003 11:50:34 +0000
From: John Levon <levon@movementarian.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Switch APIC (+nmi, +oprofile) to driver model
Message-ID: <20030210115034.GF22600@compsoc.man.ac.uk>
References: <200302091407.PAA14076@kim.it.uu.se> <20030210110108.GE2838@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210110108.GE2838@atrey.karlin.mff.cuni.cz>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *18iCSI-000E29-00*etZy/tMi.gI*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 10, 2003 at 12:01:09PM +0100, Pavel Machek wrote:

> Yes, whole oprofile/nmi interaction is ugly like hell. This way it is
> at least explicit, so people *know* its ugly.

That's no reason not do something like Mikael or I suggested.

john
