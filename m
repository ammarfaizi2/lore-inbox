Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932273AbVJIMCi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932273AbVJIMCi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 08:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932280AbVJIMCi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 08:02:38 -0400
Received: from qproxy.gmail.com ([72.14.204.201]:65113 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932273AbVJIMCh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 08:02:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=EX5A+Z5OHqHoDywMcVULhe5fecEahdrbMRKgB4wUAq1tYElSDRsJjXrJPbAYiY+yDaXnW/bMSyQSLcEKf6+oEBcYYoyi8IOEncD6bywyUIeqaiGnQgc1F0HXz0GV69auDxJWPWh6up15VQf1g/Q6mNNaK6K150tvKDRlkHgA954=
Message-ID: <b9a245c10510090502r4e87696fqe111c0071e7f2a03@mail.gmail.com>
Date: Sun, 9 Oct 2005 17:32:36 +0530
From: Vivek Kutal <vivek.kutal@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Need for SHIFT and MASK
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ,
While browsing through the code i came across macros like SHIFT , MASK
, SIZE which are used in conversion from linear address to physical
address
but this is the job of the processor (address translation) then why do
we have these macros
can anyone please explain.



--
Thanks and Regards
Vivek Kutal
http://vivekkutal.blogspot.com

"Live as if you were to die tomorrow. Learn as if you were to live forever."
