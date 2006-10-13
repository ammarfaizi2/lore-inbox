Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030180AbWJMVgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030180AbWJMVgj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030177AbWJMVgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:36:39 -0400
Received: from web83103.mail.mud.yahoo.com ([216.252.101.32]:27003 "HELO
	web83103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1030179AbWJMVgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:36:39 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=44kvs7udjAtw6Zjmqi5w3dhS40wdq2hfI1OQpNo5kVy8b4Zq5+I25PthHZN63xjVwXNguajGN0knjtSa0kjWZanPy9+ypDduebuHLER3U6StFMiUSLloJGk37MbqHAUUaODwNJvvupwJW1lV8TUbwfvGp6XufvHzz1+jnrCyKhQ=  ;
Message-ID: <20061013213638.33691.qmail@web83103.mail.mud.yahoo.com>
Date: Fri, 13 Oct 2006 14:36:38 -0700 (PDT)
From: Aleksey Gorelov <dared1st@yahoo.com>
Subject: Re: Machine reboot
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Cc: Auke Kok <auke-jan.h.kok@intel.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20061013203004.GI3039@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- Lukas Hejtmanek <xhejtman@mail.muni.cz> wrote:

> On Fri, Oct 13, 2006 at 01:27:52PM -0700, Aleksey Gorelov wrote:
> > It's not the problem at all, but served as a hint for me to try unloading driver.
> > However, from latest Lukas's findings, it seems that something (_not_ in the e1000 driver) in
> > between 2.6.18 & 2.6.19-rc2 fixes it. 
> 
> Does 2.6.19-rc1 work for you? Both with module and built in e1000 driver?
> 
  I did not try that yet. But it looks like another person on the list just complained about
reboot issue on Intel 965 with 2.6.18, .19-rc1, and .19-rc2...

Aleks.

