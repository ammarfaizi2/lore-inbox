Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267747AbUHJV2Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267747AbUHJV2Y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:28:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267740AbUHJV2Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:28:24 -0400
Received: from ppp2-adsl-200.the.forthnet.gr ([193.92.233.200]:55596 "EHLO
	ppp1-100.the.forthnet.gr") by vger.kernel.org with ESMTP
	id S267595AbUHJV2W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:28:22 -0400
From: V13 <v13@priest.com>
To: John Richard Moser <nigelenki@comcast.net>
Subject: Re: [RFC] Bug zapper?  :)
Date: Wed, 11 Aug 2004 00:30:36 +0300
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <4117D98C.2030203@comcast.net>
In-Reply-To: <4117D98C.2030203@comcast.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200408110030.37601.v13@priest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 09 August 2004 23:07, John Richard Moser wrote:
> What I found interesting was that it described bugs as
> pseudo-quantitative based on the KLOC (thousands of lines of code) for a
> code body.  The basic theory boils down to 5-50 bugs per 1000 LOC,
> approaching 5 for QA audited code.  Thus, 10000 LOC executable, 50 bugs.

I believe that you should not believe such things. They are just statistics 
and nothing more. 

If you have a 1000 lines project and:

a) Remove all empty lines means that you remove bugs?
b) Split it to 5 libraries and 5 utilities (10 projects) means that you'll 
have less bugs? 
c) ....

I don't take generalizations like this seriously and I believe that noone 
should do. It may be true that 10.000 lines of code contain 50 bugs as an 
average of all the code that has be written so far but it doesn't mean that:

a) 50 bugs require 10.000 lines
b) 50 bugs will always exist on 10.000 lines
c) All the projects out there have the same number of bugs/line

> --John
<<V13>>
