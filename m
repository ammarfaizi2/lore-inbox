Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318450AbSGSEgF>; Fri, 19 Jul 2002 00:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318455AbSGSEgF>; Fri, 19 Jul 2002 00:36:05 -0400
Received: from bitmover.com ([192.132.92.2]:40834 "EHLO bitmover.com")
	by vger.kernel.org with ESMTP id <S318450AbSGSEf6>;
	Fri, 19 Jul 2002 00:35:58 -0400
Date: Thu, 18 Jul 2002 21:38:57 -0700
From: Larry McVoy <lm@bitmover.com>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Alright, I give up.  What does the "i" in "inode" stand for?
Message-ID: <20020718213857.E23208@work.bitmover.com>
Mail-Followup-To: Larry McVoy <lm@work.bitmover.com>,
	Rob Landley <landley@trommello.org>, linux-kernel@vger.kernel.org
References: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207190432.g6J4WD2366706@pimout5-int.prodigy.net>; from landley@trommello.org on Thu, Jul 18, 2002 at 06:33:54PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 18, 2002 at 06:33:54PM -0400, Rob Landley wrote:
> I've been sitting on this question for years, hoping I'd come across the 
> answer, and I STILL don't know what the "i" is short for.  Somebody here has 
> got to know this. :)

Incore node, I believe.  In the original Unix code there was dinode and
inode if I remember correctly, for disk node and incore node.
-- 
---
Larry McVoy            	 lm at bitmover.com           http://www.bitmover.com/lm 
