Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267480AbUIIXdi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267480AbUIIXdi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 19:33:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265051AbUIIXam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 19:30:42 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:28387 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S266749AbUIIX3z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 19:29:55 -0400
Date: Thu, 9 Sep 2004 16:29:49 -0700
From: Deepak Saxena <dsaxena@plexity.net>
To: rmk@arm.linux.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6 SERIAL] Add support for word-length UART registers.
Message-ID: <20040909232949.GB5236@plexity.net>
Reply-To: dsaxena@plexity.net
References: <20040909231947.GA5236@plexity.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040909231947.GA5236@plexity.net>
Organization: Plexity Networks
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 09 2004, at 16:19, Deepak Saxena was caught saying:
> 
> 
> UARTS on several Intel IXP2000 systems are connected in such
> a way that they can only be addressed using full word accesses

s/word/long/ in linux-speak.

~Deepak

-- 
Deepak Saxena - dsaxena at plexity dot net - http://www.plexity.net/

"Unlike me, many of you have accepted the situation of your imprisonment
and will die here like rotten cabbages." - Number 6
