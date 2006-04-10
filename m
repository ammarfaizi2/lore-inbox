Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWDJB1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWDJB1K (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Apr 2006 21:27:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750861AbWDJB1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Apr 2006 21:27:10 -0400
Received: from animx.eu.org ([216.98.75.249]:63462 "EHLO animx.eu.org")
	by vger.kernel.org with ESMTP id S1750859AbWDJB1J (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Apr 2006 21:27:09 -0400
Date: Sun, 9 Apr 2006 21:36:25 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: leonie herzberg <leo@net4u.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: alpha DEAD on >=2.6.16-rc3
Message-ID: <20060410013625.GA5108@animx.eu.org>
Mail-Followup-To: leonie herzberg <leo@net4u.de>,
	linux-kernel@vger.kernel.org
References: <44397596.5020809@net4u.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44397596.5020809@net4u.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

leonie herzberg wrote:
> Hi. I already posted a bugreport on the bugzilla
> (http://bugzilla.kernel.org/show_bug.cgi?id=6351) but I feel no one is
> recognizing that; and as I see it, it's a rather hard bug since it
> throws a kernel panic immediately at boot time. I believe it has to do
> with the change made in 2.6.16-rc3 concerning "cpu_possible_map". None
> of the newer kernel versions works.
> As you can see at the first (and up to now, only) comment, this is not
> only my problem.
> Maybe it appears only in connection with SMP. I can't tell.

I'm not sure if this is similar or not.  I compiled 2.6.16 for my alpha 2
days ago.  I've had nothing but lockup/halting problems with it and went back
to 2.4.

This is a noritake machine (alphaserver 1000a 4/266) 160mb ram and a mylex
dac960pdu (IIRC) raid controller.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
 Got Gas???
