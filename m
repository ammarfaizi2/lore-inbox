Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbTKSN1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 08:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264089AbTKSN1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 08:27:46 -0500
Received: from eik.ii.uib.no ([129.177.16.3]:12284 "EHLO mail.ii.uib.no")
	by vger.kernel.org with ESMTP id S264080AbTKSN1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 08:27:45 -0500
Subject: Re: 2.6.0-test9-mm4 - kernel BUG at arch/i386/mm/fault.c:357!
From: "Ronny V. Vindenes" <s864@ii.uib.no>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20031119130220.GT22764@holomorphy.com>
References: <1069246427.5257.12.camel@localhost.localdomain>
	 <20031119130220.GT22764@holomorphy.com>
Content-Type: text/plain
Message-Id: <1069248455.5257.26.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Wed, 19 Nov 2003 14:27:36 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.9 (+)
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1AMSMu-0007BG-00*B09Fery8BII*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-11-19 at 14:02, William Lee Irwin III wrote:
> On Wed, Nov 19, 2003 at 01:53:47PM +0100, Ronny V. Vindenes wrote:
> > Running the game Enemy Territory triggers this (log is from running it 3
> > times in a row) every time. Haven't been able to trigger it with any
> > other programs. Machine is athlon64 running all 32bit.
> > On a happier note, interactivity problems are gone with the new acpi pm
> > timer patch.
> 
> What sound card?
> 

Hercules Fortissimo III (snd-cs46xx), there's also a Terratec EWX24/96
(snd-ice1712) installed but it's not in active use.

-- 
Ronny V. Vindenes <s864@ii.uib.no>

