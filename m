Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261847AbVFJPYx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261847AbVFJPYx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 11:24:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262568AbVFJPYw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 11:24:52 -0400
Received: from web33315.mail.mud.yahoo.com ([68.142.206.130]:5496 "HELO
	web33315.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S261847AbVFJPYu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 11:24:50 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=h3Dll/Sv/Htg3B2L0XpZUfQUG2V9CFiOhlplvifT2Do2wvgwQnVsAW0V1lPZImUmh91Ti+kzrX7Ynk1A3K4sWz19gmGKCpleUUVVqVZQK7XnWFJN1vkwia3LwSuwjgfh+3080jxvSGfpxx+hGwCic59CiOcTft8Vws+xGfEXGuQ=  ;
Message-ID: <20050610152450.82261.qmail@web33315.mail.mud.yahoo.com>
Date: Fri, 10 Jun 2005 08:24:50 -0700 (PDT)
From: li nux <lnxluv@yahoo.com>
Subject: 2.6: problem with module tainting the kernel
To: linux <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In 2.6 kernels how to assure that on inserting our own
module, it doesn't throw the warning:

"unsupported module, tainting kernel"

what tainting depends on apart from the license string ?


		
__________________________________ 
Yahoo! Mail Mobile 
Take Yahoo! Mail with you! Check email on your mobile phone. 
http://mobile.yahoo.com/learn/mail 
