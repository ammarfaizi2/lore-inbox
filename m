Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751129AbWDEHD6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751129AbWDEHD6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Apr 2006 03:03:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbWDEHD6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Apr 2006 03:03:58 -0400
Received: from smtp108.mail.mud.yahoo.com ([209.191.85.218]:61566 "HELO
	smtp108.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751129AbWDEHD5 (ORCPT <rfc822;Linux-kernel@vger.kernel.org>);
	Wed, 5 Apr 2006 03:03:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=c7oadi0EHvDh04aJB883jbAfnwZ1ANyrEDsWl6hFxmGApsKRUSyHQxzhzU2PdHch4fBdw9Nt553J0tWPsxMUm6LsZUAudB6emcSgCTBTnFEVtM5ZG0nph1/ZT8psi03TaaFgaq5oW+HU1JWxMCB1K/AfrY242OlFTuhj3NtOutA=  ;
Message-ID: <44326738.1090707@yahoo.com.au>
Date: Tue, 04 Apr 2006 22:31:52 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: pomac@vapor.com
CC: Linux-kernel@vger.kernel.org
Subject: Re: [OOPS] related to swap?
References: <1144104593.30036.38.camel@localhost>
In-Reply-To: <1144104593.30036.38.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:

> Yes, i run a tainted kernel! either live with it or ignore this mail =)

> starting swap lead to a deadlock within 15 mins

> I have never had the energy to perform a full memtext86+

It would be useful if you could perform a memtest overnight one night,
then run a non-patched and non-tained 2.6.16.1 kernel, and try to
reproduce the problems.

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
