Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750758AbVLFPvF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbVLFPvF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 10:51:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVLFPvF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 10:51:05 -0500
Received: from web34103.mail.mud.yahoo.com ([66.163.178.101]:51355 "HELO
	web34103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750758AbVLFPvE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 10:51:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=E9nyifvayCBYePHNV1M1XMFjMSW4JfP9mOyfFD5MX3S82ItqSbFY5uz5R54JcCgTKDloouRwbYTOYYXGGBjoF8ocOuqmn0qellRfg52QA60Isk7onE4v0sa6Awrnu+VV86PTOD0quvqJu4wPfXOj6mVsJGplKzZgz8vgjVfeDg0=  ;
Message-ID: <20051206155103.63555.qmail@web34103.mail.mud.yahoo.com>
Date: Tue, 6 Dec 2005 07:51:03 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: nfs unhappiness with memory pressure
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <1133822367.8003.5.camel@lade.trondhjem.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Trond Myklebust <trond.myklebust@fys.uio.no> wrote:

> Gah... This is the problem:
...
> 
> Ah, well... Try GFP_ATOMIC first, and see if that helps.


That DOES IT!!!!

-Kenny



		
__________________________________________ 
Yahoo! DSL – Something to write home about. 
Just $16.99/mo. or less. 
dsl.yahoo.com 

