Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262800AbTCKCaH>; Mon, 10 Mar 2003 21:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262802AbTCKCaH>; Mon, 10 Mar 2003 21:30:07 -0500
Received: from mallard.mail.pas.earthlink.net ([207.217.120.48]:55246 "EHLO
	mallard.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S262800AbTCKCaH>; Mon, 10 Mar 2003 21:30:07 -0500
Date: Mon, 10 Mar 2003 21:46:29 -0500
To: efault@gmx.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler starvation running irman with 2.5.64bk2
Message-ID: <20030311024629.GA391@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The only difference I see is that reniced task wasn't starved with this
> kernel... wonder what the difference is.  

One more thing.  After <ctrl c> interrupting irman process load, 
ssh into the box works.
-- 
Randy Hron
http://home.earthlink.net/~rwhron/kernel/bigbox.html

