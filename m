Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261963AbTBSV7z>; Wed, 19 Feb 2003 16:59:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261996AbTBSV7z>; Wed, 19 Feb 2003 16:59:55 -0500
Received: from f61.pav2.hotmail.com ([64.4.37.61]:49935 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S261963AbTBSV7y>;
	Wed, 19 Feb 2003 16:59:54 -0500
X-Originating-IP: [129.219.25.77]
From: "shesha bhushan" <bhushan_vadulas@hotmail.com>
To: linux-kernel@vger.kernel.org, kernelnewbies@nl.linux.org
Subject: how to convert iovecs to page?
Date: Wed, 19 Feb 2003 22:09:52 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F610ZnxV9j1TWCKis9n00000cb2@hotmail.com>
X-OriginalArrivalTime: 19 Feb 2003 22:09:53.0156 (UTC) FILETIME=[A0D65C40:01C2D863]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
  I want to use tcp_sendpage to send data from one end to another. But 
tcp_sendpage accepts data in the form of PAGE. But in my application I have 
data in iovecs form. Is there a way I can convert data in iovecs form to 
PAGE form so that I can feed it to the tcp_sendpage ?

Thanking You
Shesha





_________________________________________________________________
Add photos to your messages with MSN 8. Get 2 months FREE*. 
http://join.msn.com/?page=features/featuredemail

