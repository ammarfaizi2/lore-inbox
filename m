Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932180AbWC1VHL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932180AbWC1VHL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Mar 2006 16:07:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbWC1VHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Mar 2006 16:07:11 -0500
Received: from smtp110.mail.mud.yahoo.com ([209.191.85.220]:29798 "HELO
	smtp110.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932180AbWC1VHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Mar 2006 16:07:09 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=OV2XZBszKg/PDsXrb78nqsM/UT0MfZ7hi2jtfeCruhuD2CMT00wI5XjJwHaGhHhmQlrPbZz/RpI9zYTg/j6/laAs+BkahATOPEAFfAB2tZvpIxZt+Ha/xNRsb/oxsfnI29x5Jhj2B6goVterHVf+jbN+WnfirU8Om94CcsD4oGc=  ;
Message-ID: <44295C17.1050202@yahoo.com.au>
Date: Wed, 29 Mar 2006 01:53:59 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Poetzl <herbert@13thfloor.at>
CC: Kirill Korotaev <dev@sw.ru>, "Eric W. Biederman" <ebiederm@xmission.com>,
       haveblue@us.ibm.com, linux-kernel@vger.kernel.org, devel@openvz.org,
       serue@us.ibm.com, akpm@osdl.org, sam@vilain.net,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>, Pavel Emelianov <xemul@sw.ru>,
       Stanislav Protassov <st@sw.ru>
Subject: Re: [RFC] Virtualization steps
References: <44242A3F.1010307@sw.ru> <44242D4D.40702@yahoo.com.au> <4428FB90.5000601@sw.ru> <4428FEA5.9020808@yahoo.com.au> <20060328153558.GF14576@MAIL.13thfloor.at>
In-Reply-To: <20060328153558.GF14576@MAIL.13thfloor.at>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Poetzl wrote:
> On Tue, Mar 28, 2006 at 07:15:17PM +1000, Nick Piggin wrote:

[...]

Thanks for the clarifications, Herbert.

>>Ie. is there any consensus about the future of these patches?  
> 
> 
> what patches?

One's being thrown around lkml, and future ones being talked about.
Patches ~= changes to kernel.

> what future?

I presume everyone's goal is to get something into the kernel?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
