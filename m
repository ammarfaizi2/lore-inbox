Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266020AbUA1SIe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 13:08:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265995AbUA1SHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 13:07:42 -0500
Received: from anor.ics.muni.cz ([147.251.4.35]:44939 "EHLO anor.ics.muni.cz")
	by vger.kernel.org with ESMTP id S266007AbUA1SGn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 13:06:43 -0500
Date: Wed, 28 Jan 2004 19:06:39 +0100
From: Jan Kasprzak <kas@informatics.muni.cz>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMP AMD64 (Tyan S2882) problems.
Message-ID: <20040128190639.F6714@fi.muni.cz>
References: <20040127190911.B13769@fi.muni.cz.suse.lists.linux.kernel> <p73fze1fdk4.fsf@nielsen.suse.de> <20040127224931.D24747@fi.muni.cz> <20040128180702.E6714@fi.muni.cz> <20040128183142.0e5963b7.ak@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040128183142.0e5963b7.ak@suse.de>; from ak@suse.de on Wed, Jan 28, 2004 at 06:31:42PM +0100
X-Muni-Spam-TestIP: 147.251.48.3
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
: It's probably an ACPI bug.  I don't have time to look into it right now though.
: You can file a bug in kernel bugzilla so that it isn't forgotten.

	I did. http://bugzilla.kernel.org/show_bug.cgi?id=1966

-Yenya

-- 
| Jan "Yenya" Kasprzak  <kas at {fi.muni.cz - work | yenya.net - private}> |
| GPG: ID 1024/D3498839      Fingerprint 0D99A7FB206605D7 8B35FCDE05B18A5E |
| http://www.fi.muni.cz/~kas/   Czech Linux Homepage: http://www.linux.cz/ |
 Any compiler or language that likes to hide things like memory allocations
 behind your back just isn't a good choice for a kernel.   --Linus Torvalds
