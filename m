Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318323AbSGRSuU>; Thu, 18 Jul 2002 14:50:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318324AbSGRSuU>; Thu, 18 Jul 2002 14:50:20 -0400
Received: from stargazer.compendium-tech.com ([64.156.208.76]:44559 "EHLO
	stargazer.compendium.us") by vger.kernel.org with ESMTP
	id <S318323AbSGRSuT>; Thu, 18 Jul 2002 14:50:19 -0400
Date: Thu, 18 Jul 2002 11:51:51 -0700 (PDT)
From: Kelsey Hudson <khudson@compendium.us>
X-X-Sender: khudson@betelgeuse.compendium-tech.com
To: Joerg Schilling <schilling@fokus.gmd.de>
cc: alan@lxorguk.ukuu.org.uk, <linux-kernel@vger.kernel.org>
Subject: Re: IDE/ATAPI in 2.5
In-Reply-To: <200207141407.g6EE7fcL019119@burner.fokus.gmd.de>
Message-ID: <Pine.LNX.4.44.0207181148290.2065-100000@betelgeuse.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 14 Jul 2002, Joerg Schilling wrote:

> >There are lots that fudge around and pretend scsi is the block layer
> >when it is not. That sort of misses the point and slows down high end
> >raid cards.
> 
> It seems that you miss to understand the needed underlying driver structures.
> SCSI is not a block layer, it is a generic transport.

Didn't he just say that? Or does " ... pretend scsi is the block layer 
*WHEN IT IS NOT*" mean something else than the obvious?

-- 
 Kelsey Hudson                                       khudson@compendium.us
 Software Engineer/UNIX Systems Administrator
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------

