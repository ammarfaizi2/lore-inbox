Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132691AbRDCHde>; Tue, 3 Apr 2001 03:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132693AbRDCHdY>; Tue, 3 Apr 2001 03:33:24 -0400
Received: from infortrend.com.tw ([203.67.221.1]:15885 "EHLO infortrend.com.tw")
	by vger.kernel.org with ESMTP id <S132691AbRDCHdL>;
	Tue, 3 Apr 2001 03:33:11 -0400
Reply-To: <warren@infortrend.com.tw>
From: "warren" <warren@infortrend.com.tw>
To: <linux-kernel@vger.kernel.org>
Date: Tue, 3 Apr 2001 15:21:18 +0800
Message-ID: <005501c0bc0e$ae026350$321ea8c0@saturn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
    I have problems about the system calls on Linux. Please do me a favor.

The problem is:

If operation 1 that renames A to B and operation 2 that renames B to C, and
the two operations run concurrently.
Is it possible  that operation 2 is invoked and operation 1 does not return
? How does Linux serialize the two operations?

Thanks in advance.

Warren


