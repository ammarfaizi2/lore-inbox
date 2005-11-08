Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965201AbVKHF36@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965201AbVKHF36 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 00:29:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965208AbVKHF36
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 00:29:58 -0500
Received: from smtp206.mail.sc5.yahoo.com ([216.136.129.96]:55160 "HELO
	smtp206.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S965201AbVKHF35 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 00:29:57 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=Mqwm17P9nF5QGa39r4c/35+LSXKFjo7E+osYtj0HuXaeGTtr9BtWyZU/afeCQYbNQ337xiNJuDu71S61PtVKuiSX6Tsf3qv/myRJ7zy3OpXAzBSwwYQ8y2oozrBqgIABfEjgQJ8cJ/MPgoOiEkUY/nxuG147FMYg+dfb9ibBLXQ=  ;
Message-ID: <4370384E.6000402@yahoo.com.au>
Date: Tue, 08 Nov 2005 16:31:58 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Jackson <pj@sgi.com>
CC: "Rohit, Seth" <rohit.seth@intel.com>, akpm@osdl.org, torvalds@osdl.org,
       linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Cleanup of __alloc_pages
References: <20051107174349.A8018@unix-os.sc.intel.com> <20051107190715.4d7b0f71.pj@sgi.com>
In-Reply-To: <20051107190715.4d7b0f71.pj@sgi.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson wrote:

> I thought Nick had an alternative proposal, involving just boolean

Hi Paul,

I sent the cleanup patch plus some modifications to lkml in a
subthread but forgot to CC you on it.

Let me know if you have any comments or suggestions on it.

-- 
SUSE Labs, Novell Inc.

Send instant messages to your online friends http://au.messenger.yahoo.com 
