Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264774AbTFLHmy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 03:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264777AbTFLHmx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 03:42:53 -0400
Received: from wohnheim.fh-wedel.de ([195.37.86.122]:24997 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S264774AbTFLHmx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 03:42:53 -0400
Date: Thu, 12 Jun 2003 09:56:18 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Michael Knigge <Michael.Knigge@set-software.de>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Frank Cusack <fcusack@fcusack.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-rc8
Message-ID: <20030612075618.GA31097@wohnheim.fh-wedel.de>
References: <Pine.LNX.4.55L.0306101845460.30401@freak.distro.conectiva> <20030610165622.A17342@google.com> <Pine.LNX.4.55L.0306102109340.30401@freak.distro.conectiva> <Pine.LNX.4.55L.0306111815100.31893@freak.distro.conectiva> <20030612.6274686@knigge.local.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030612.6274686@knigge.local.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 June 2003 06:27:46 +0000, Michael Knigge wrote:
> 
> imho the patch have to be included in 2.4.21 and (imho) it is a bad 
> practice to release a piece of software with a known bug (especially 
> if a fix is available).

Is it good practice not to release, when the last version has even
more known bugs?  It's a trade-off and those are hard to get
objectively correct.

Personally, I still like the idea of a bugfix-only patch against
2.4.current [1], but in it's current state it just isn't taken serious
by 90% of kernel.org kernel users.

[1] http://www.hardrock.org/kernel/current-updates/

Jörn

-- 
Eighty percent of success is showing up.
-- Woody Allen
