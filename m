Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266114AbTAFEsC>; Sun, 5 Jan 2003 23:48:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266006AbTAFEsC>; Sun, 5 Jan 2003 23:48:02 -0500
Received: from mailout07.sul.t-online.com ([194.25.134.83]:4751 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S266114AbTAFEsC>; Sun, 5 Jan 2003 23:48:02 -0500
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Patch(2.5.54): devfs shrink - integration candidate
References: <20030105201413.A10685@adam.yggdrasil.com>
	<20030105203725.A10808@adam.yggdrasil.com>
From: Andi Kleen <ak@muc.de>
Date: 06 Jan 2003 05:56:22 +0100
In-Reply-To: <20030105203725.A10808@adam.yggdrasil.com>
Message-ID: <m3d6naq3k9.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" <adam@yggdrasil.com> writes:
> 
> 	Finally, I'd like to move forward toward getting this into
> Linus's kernel.  Any blessings, curses, requests for changes or advice
> on the best way to proceed would be appreciated.

Me thinks you're two to three months too late for 2.5. This looks definitely not like
a good idea to merge in a feature/code freeze, when the main goal should be to
finally get 2.6 out. Submit it when 2.7 opens.

-Andi
