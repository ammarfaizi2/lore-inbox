Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263360AbTIWM5G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 08:57:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263361AbTIWM5F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 08:57:05 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:42769 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S263360AbTIWM5D
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 08:57:03 -0400
Date: Tue, 23 Sep 2003 13:57:02 +0100
From: John Levon <levon@movementarian.org>
To: chas3@users.sourceforge.net
Cc: davem@redhat.com, Remi Colinet <remi.colinet@wanadoo.fr>,
       linux-kernel@vger.kernel.org
Subject: Re: [Patch] Compile fix for 2.6.0-test5-mm4 in net/atm/proc.c
Message-ID: <20030923125702.GB92228@compsoc.man.ac.uk>
References: <remi.colinet@wanadoo.fr> <3F6F52AE.3080206@wanadoo.fr> <200309231250.h8NCopkT023939@ginger.cmf.nrl.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200309231250.h8NCopkT023939@ginger.cmf.nrl.navy.mil>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1A1mj0-0008cK-Cf*nkxYvIt5BX2*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 23, 2003 at 08:50:52AM -0400, chas williams wrote:

> instead of doing this, it would probably be cleaner to put the
> ifdef inside the clip header file and just return 0 when !CLIP.

What are your plans with mine and Mitchell's stuff that removes all this
ops crap altogether ?

The patch series works, as far as I know.

regards
john

-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
