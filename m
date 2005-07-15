Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262934AbVGOAhN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262934AbVGOAhN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Jul 2005 20:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262937AbVGOAhN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Jul 2005 20:37:13 -0400
Received: from wproxy.gmail.com ([64.233.184.196]:46156 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262934AbVGOAhL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Jul 2005 20:37:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=kYoH4X22sFRf+3QyHL9ZCe8TDHaRxMN4bOCPz+TIru6mnR6HiQp4qRdbsg5KQRXZ50KllvvBHOvMl9JW5ZvawKU9YtQ/fxEV0QCbV8ZFInAimEn+m5r/wZbz074+iNahrRg/WBJ7YgEgN6A3bpaQQRV1Stoel/xC3Usda12FaNo=
Message-ID: <e64da0120507141737445055c9@mail.gmail.com>
Date: Fri, 15 Jul 2005 06:07:11 +0530
From: Purshotam Roy <purshotam.roy@gmail.com>
Reply-To: Purshotam Roy <purshotam.roy@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Question on thread_info
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,
	Could anybody provide any information as to why thread_info is kept
at the top of the stack. Also, does it mean that when thread_info is
kept it will be kept at the bottom of the heap itself also.
