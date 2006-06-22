Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751476AbWFVP0W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751476AbWFVP0W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 11:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWFVP0W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 11:26:22 -0400
Received: from web33301.mail.mud.yahoo.com ([68.142.206.116]:64628 "HELO
	web33301.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751476AbWFVP0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 11:26:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=mjlEF+D1/w0SWCxiQJkgGoifrHK2NuVoaiu2kSLswOXRVymb5FNmqYqSlarbVii1rAC0D02xmDTDez6zo4DkaH0dial0hq0iYQuV25tIUN+Ge4ZzhqaiB9L09t/btDKg1zn8PrvystghAzHRQNMJzRfWmQIWquEhwez0i6LHzfA=  ;
Message-ID: <20060622152621.92347.qmail@web33301.mail.mud.yahoo.com>
Date: Thu, 22 Jun 2006 08:26:21 -0700 (PDT)
From: Danial Thom <danial_thom@yahoo.com>
Reply-To: danial_thom@yahoo.com
Subject: Measuring tools - top and interrupts
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.6.17, it seems that top is reporting
100% idle with a network load of about 75K pps
(bridged) , which seems unlikely. Is it possible
that system load accounting is turned off by some
tunning knob?

Is there something that shows the current
interrupts/second in LINUX (such as systat in
'BSD)?

DT

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
