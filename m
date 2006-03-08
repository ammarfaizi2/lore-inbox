Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751287AbWCHJcY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751287AbWCHJcY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 04:32:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751531AbWCHJcY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 04:32:24 -0500
Received: from smtp109.mail.mud.yahoo.com ([209.191.85.219]:37034 "HELO
	smtp109.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751044AbWCHJcY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 04:32:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=iazpMzqoRH3DHBy03mUC1QXfxhjISAt55CEG+3R5P2ywK/t07kR9fkGCRzXfcWZiqxgMf2cqaZ553jJuVAMIctPhTOud4QoTQRwFJMRcPtVW2snNRK1grsmLko9HuYFuRIqwJ/1op+TprNqP/S+XOph/fzPkxHadWndYwsWKrg0=  ;
Message-ID: <440EA2A2.3040601@yahoo.com.au>
Date: Wed, 08 Mar 2006 20:23:46 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: 76306.1226@compuserve.com, torvalds@osdl.org, lee.schermerhorn@hp.com,
       michaelc@cs.wisc.edu, jesper.juhl@gmail.com,
       linux-kernel@vger.kernel.org, James.Bottomley@steeleye.com
Subject: Re: Slab corruption in 2.6.16-rc5-mm2
References: <200603080129_MC3-1-BA15-47C9@compuserve.com>	<440E969B.2080301@yahoo.com.au>	<20060308004659.163b6e29.akpm@osdl.org>	<440E9DBE.209@yahoo.com.au> <20060308011254.6cc7a190.akpm@osdl.org>
In-Reply-To: <20060308011254.6cc7a190.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> Well yes, Lee sent the fix to the guy who he got the kernel release from in
> the reasonable expectation that I'd take care of getting it to where it
> needed to be.
> 
> Problem is, a) I screwed up, b) James screwed up and c) someone just
> happened to change those few lines of code in that place within a few-day
> window.
> 
> That triple-combo doesn't happen very often.
> 

I guess what I'm advocating isn't foolproof either: the guy who wrote
the patch might die (knock on wood) ;)

Carry on.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
