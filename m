Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751124AbVKNNiF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751124AbVKNNiF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 08:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751123AbVKNNiF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 08:38:05 -0500
Received: from web50205.mail.yahoo.com ([206.190.38.46]:43965 "HELO
	web50205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751122AbVKNNiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 08:38:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=MdP1/g0ph5w1pGscTBPeFoKB1s7nqIgyB4UOYRPW+Z89MijV8W3lmkS0oi8nY8WVL0a/ZEjbQIj2tQZW6rs9eoZmTsBl9fXmV8E4lkT+lyNKhZn5n1P5swHsuy3SOFtkS4a+rLVccH9uKVY2ATQttbrokFiKU+tW0b2DVwuIiC8=  ;
Message-ID: <20051114133802.38755.qmail@web50205.mail.yahoo.com>
Date: Mon, 14 Nov 2005 05:38:02 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This will break ndiswrapper. Why can't we just leave this in and let people choose? 

I code, therefore I am


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
