Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267693AbTAMJJY>; Mon, 13 Jan 2003 04:09:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267711AbTAMJJY>; Mon, 13 Jan 2003 04:09:24 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4872 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267693AbTAMJJX>; Mon, 13 Jan 2003 04:09:23 -0500
Date: Mon, 13 Jan 2003 09:18:11 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.56-bug
Message-ID: <20030113091811.B12379@flint.arm.linux.org.uk>
Mail-Followup-To: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
	LKML <linux-kernel@vger.kernel.org>
References: <E18Xh1V-0000R7-00@raistlin.arm.linux.org.uk> <20030113004940.K628@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030113004940.K628@nightmaster.csn.tu-chemnitz.de>; from ingo.oeser@informatik.tu-chemnitz.de on Mon, Jan 13, 2003 at 12:49:40AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:49:40AM +0100, Ingo Oeser wrote:
> Mind to get a patch on top of your doing exactly this
> modification?

That is something for the architecture people to sort out.  I, for
instance, don't know if an 'asm(".long 0");' will actually cause the
process to terminate.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

