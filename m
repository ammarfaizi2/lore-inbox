Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129991AbRAZUXw>; Fri, 26 Jan 2001 15:23:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130085AbRAZUXn>; Fri, 26 Jan 2001 15:23:43 -0500
Received: from smtp-rt-3.wanadoo.fr ([193.252.19.155]:57264 "EHLO
	apicra.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S129991AbRAZUXX>; Fri, 26 Jan 2001 15:23:23 -0500
Date: Fri, 26 Jan 2001 21:21:04 +0100
From: patrick.mourlhon@wanadoo.fr
To: linux-kernel@vger.kernel.org
Subject: Re: Renaming lost+found
Message-ID: <20010126212104.A14358@MourOnLine.dnsalias.org>
Reply-To: patrick.mourlhon@wanadoo.fr
In-Reply-To: <20010126204531.A14179@MourOnLine.dnsalias.org> <200101262005.PAA05246@mah21awu.cas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101262005.PAA05246@mah21awu.cas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

alias ls="ls -I "lost+found"'

On Fri, 26 Jan 2001, Mike Harrold wrote:

> > 
> > 
> > An other maybe too obvious way, could be to :
> > 
> > alias ls='ls | grep -v "lost+found"'
> 
> This turns multiple column output into one single column.
> 
> Regards,
> 
> /Mike
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
