Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262408AbTCMPbr>; Thu, 13 Mar 2003 10:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262409AbTCMPbr>; Thu, 13 Mar 2003 10:31:47 -0500
Received: from bitmover.com ([192.132.92.2]:42705 "EHLO mail.bitmover.com")
	by vger.kernel.org with ESMTP id <S262408AbTCMPbq>;
	Thu, 13 Mar 2003 10:31:46 -0500
Date: Thu, 13 Mar 2003 07:42:27 -0800
From: Larry McVoy <lm@bitmover.com>
To: David Mansfield <lkml@dm.cobite.com>
Cc: Larry McVoy <lm@bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] BK->CVS (real time mirror)
Message-ID: <20030313154227.GL7275@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	David Mansfield <lkml@dm.cobite.com>, Larry McVoy <lm@bitmover.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0303131026380.7061-100000@admin>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0303131026380.7061-100000@admin>
User-Agent: Mutt/1.4i
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> SUGGESTION:
> Put the '(Logical change x.yyyy)' text into EVERY log message that is a 
> port of the logical change, including the 'main' commit to the ChangeSet, 
> that commit has the BKrev: in it (it's missing from this one file's log 
> message).

The x.yyyy is the revision number of the ChangeSet file.  So the information
is redundant.
-- 
---
Larry McVoy              lm at bitmover.com          http://www.bitmover.com/lm
