Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318798AbSH1Mok>; Wed, 28 Aug 2002 08:44:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318802AbSH1Moj>; Wed, 28 Aug 2002 08:44:39 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:57572 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S318798AbSH1Moj>; Wed, 28 Aug 2002 08:44:39 -0400
Subject: Re: Linux-2.4.20-pre4-ac1: i810_audio broken
From: Juergen Sawinski <juergen.sawinski@mpimf-heidelberg.mpg.de>
To: Andris Pavenis <pavenis@latnet.lv>
Cc: Doug Ledford <dledford@redhat.com>,
       "linux-kernel@vger" <linux-kernel@vger.kernel.org>
In-Reply-To: <200208281004.07891.pavenis@latnet.lv>
References: <200208271253.12192.pavenis@latnet.lv>
	<20020827144629.E28828@redhat.com>  <200208281004.07891.pavenis@latnet.lv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 28 Aug 2002 14:51:17 +0200
Message-Id: <1030539078.1454.8.camel@voyager>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Can you drop in the old (working) source into the new tree and see if
that works? If that works I'll try making a step by step patch series,
to see what breaks it.

George

On Wed, 2002-08-28 at 09:04, Andris Pavenis wrote:
> Verified that sound is already broken with 2.4.20-pre1-ac2, but works with
> i810_audio.c from 2.4.19-pre1-ac1. Commenting 2 above mentioned lines out 
> doesn't help
> 
> Andris
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Juergen "George" Sawinski
Max-Planck-Institute for Medical Research
Dept. of Biomedical Optics
Jahnstr. 29
D-69120 Heidelberg
Germany

Phone:  +49-6221-486-309
Fax:    +49-6221-486-325

priv.
Phone:  +49-6221-418 848
Mobile: +49-171-532 5302

