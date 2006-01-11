Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932667AbWAKSyn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932667AbWAKSyn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:54:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWAKSyn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:54:43 -0500
Received: from web34102.mail.mud.yahoo.com ([66.163.178.100]:40847 "HELO
	web34102.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932637AbWAKSym (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:54:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=OrlVpchkI04HhBG68L7C/u9Czz2sZo2ILlrwxde1i3EW78PL1+3UJ5w3seIpDHdBVjSqTrai3ESnmRDW/fh4gZY4SbV1gZtOQJ8tIfSaR8z9A3kILrhj83ySyOHQLGUqmzwTlCEx3it8kMMoH6G60M+AFrkEmcvS/D486FbW9ww=  ;
Message-ID: <20060111185441.37826.qmail@web34102.mail.mud.yahoo.com>
Date: Wed, 11 Jan 2006 10:54:41 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: Is user-space AIO dead?
To: Benjamin LaHaise <bcrl@kvack.org>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20060111184112.GA21922@kvack.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Benjamin LaHaise <bcrl@kvack.org> wrote:
> It all depends on which database engine you're using.
Not interrested in using, more interrested in building.

> Getting Oracle 
> tuned to the Linux AIO implementation took a few revisions, but what's 
> out in the fields these days makes good use of aio to gain 10-15% on 
> the usual large industry standard database benchmark.

I was about to start out testing libaio for a simple transaction engine and read this paper, so I
thought it prudent to ask around before investing too much effort.

Are there any more up-to-date references?

-Kenny


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
