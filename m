Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932292AbVLAPpX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbVLAPpX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Dec 2005 10:45:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932289AbVLAPpX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Dec 2005 10:45:23 -0500
Received: from smtp207.mail.sc5.yahoo.com ([216.136.129.97]:58505 "HELO
	smtp207.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S932279AbVLAPpW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Dec 2005 10:45:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=HQes7NQKoRWO4IKkqI2m3hoh1JlBrzD2H4uLZRTj8PO/UpIb99v7T1raQ7ZJcNSwEOSqJvKwgPrDPWZtHR9qZqf1KaZOQm0QggGmTyBCJDqPKma4EgYVO0Kl4gBWhrgJBIhpxG6RXp4rJm7CJg7TLIrZorcoXtiSRIDrzPqQdZg=  ;
Message-ID: <438E851B.2070300@yahoo.com.au>
Date: Thu, 01 Dec 2005 16:07:39 +1100
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050831 Debian/1.7.8-1sarge2
X-Accept-Language: en
MIME-Version: 1.0
To: Ismail Donmez <ismail@uludag.org.tr>
CC: linux-kernel@vger.kernel.org
Subject: Re: More 2.6.15-rc3 problems
References: <200512010419.48394.ismail@uludag.org.tr>
In-Reply-To: <200512010419.48394.ismail@uludag.org.tr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ismail Donmez wrote:

>Hi,
>
>Looks like gdb doesn't work with 2.6.15-rc3 kernel. Trying to run ls or any 
>other binary crashes gdb and ooopses kernel. Here is the log :
>
>  
>

Should be fixed in git head, so you could try 2.6.15-rc3-git1, or
wait for -rc4.

Thanks for reporting!

Nick


Send instant messages to your online friends http://au.messenger.yahoo.com 
