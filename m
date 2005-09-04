Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750893AbVIDOwA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVIDOwA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 10:52:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750898AbVIDOwA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 10:52:00 -0400
Received: from web50202.mail.yahoo.com ([206.190.38.43]:22360 "HELO
	web50202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750885AbVIDOv7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 10:51:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=SlxzMWLtSmI/kTuBccGE8XqXShDx8ZPlWc5pFMJaVlhTCTW6LeT0c8GA+vDWSlBheJNbkn/o0M4EiIKi8PyjS8YykBxwU7K/RZkZHS+tljYqdI+J00Yty7aSG0kbINt3kBR0zDdilRJh4t3G1SdXaHKGJrcO9edmCgYIekfDZNY=  ;
Message-ID: <20050904145129.53730.qmail@web50202.mail.yahoo.com>
Date: Sun, 4 Sep 2005 07:51:29 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: re: RFC: i386: kill !4KSTACKS
To: linux-kernel@vger.kernel.org, vda@ilport.com.ua
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please don't tell me to "care for closed-source drivers". 
ndiswrapper is NOT closed source. And I'm not asking you to "care".

>I don't want the pain of debugging crashes on the machines which run unknown code
>in kernel space.
I'm not asking you to debug crashes. I'm simply requesting that the
kernel stack size situation remain as it is: with 8K as the default
and 4K configurable. 



>vda



I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
