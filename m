Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293691AbSCKLOh>; Mon, 11 Mar 2002 06:14:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293692AbSCKLOZ>; Mon, 11 Mar 2002 06:14:25 -0500
Received: from falcon.mail.pas.earthlink.net ([207.217.120.74]:39363 "EHLO
	falcon.prod.itd.earthlink.net") by vger.kernel.org with ESMTP
	id <S293691AbSCKLOM>; Mon, 11 Mar 2002 06:14:12 -0500
Date: Mon, 11 Mar 2002 06:19:09 -0500
To: green@namesys.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Opss! on 2.5.6 with ReiserFS
Message-ID: <20020311061909.A25806@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > I have got oops at boot time from 2.5.6-pre3 and 2.5.6 on
> > system with reiserfs root filesystem on ide.  
> 
> This is a known merge problem, attached patch will cure it.

Thanks Oleg.  I can mount reiserfs / with the patch.  :)

-- 
Randy Hron

