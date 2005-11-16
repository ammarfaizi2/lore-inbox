Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030184AbVKPGF7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030184AbVKPGF7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 01:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030186AbVKPGF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 01:05:59 -0500
Received: from web34115.mail.mud.yahoo.com ([66.163.178.113]:14224 "HELO
	web34115.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030184AbVKPGF6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 01:05:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G1AYcOAbOYKrUMpsFfAGmezc/B/IaMPtfBf6G2b9hfbq8xlGx6SfsLQJV4GXmsBwWn1uuNsmACI8YLyYaV6FGBCDl156sxcaYywZlhw4L5UuitIj67oBNA0kwSg+HdR0Lsn4uskWnf95umt5UnnMJQwBKTFYVf+24csLBEJ1CWQ=  ;
Message-ID: <20051116060557.255.qmail@web34115.mail.mud.yahoo.com>
Date: Tue, 15 Nov 2005 22:05:57 -0800 (PST)
From: Kenny Simpson <theonetruekenny@yahoo.com>
Subject: Re: mmap over nfs leads to excessive system load
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20051116043152.GF6916@holomorphy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- William Lee Irwin III <wli@holomorphy.com> wrote:
> 67%, or 2/3 of the samples, are in the top 6 functions. Have you tried
> instruction-level profiling? It would be interesting to see what
> codepaths within the functions are the largest offenders.
> 
> 
> -- wli
> 
I'm a little new to oprofile, but I'm willing to try any configuration or set of flags that could
be useful.
Are you referring to the -d option in opreport?
 --details / -d
              Show per-instruction details for all selected symbols.

I'll give it a go when I get back to work.

-Kenny



	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
