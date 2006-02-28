Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750742AbWB1EXQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750742AbWB1EXQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Feb 2006 23:23:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750795AbWB1EXQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Feb 2006 23:23:16 -0500
Received: from xproxy.gmail.com ([66.249.82.201]:3524 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750742AbWB1EXP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Feb 2006 23:23:15 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=co7wotLzQS+i7v5U2qu1Xz9fAJCVc4LJRo/4koaHYNDO1HDkB3/Aik2+KHyfUAmcXAGH94q5admfAbINy2WV5hDS+it5bMCSdhwhxVfNT/unjGfIDotrjpuyxRCMklEwY9eG4L65crfYq3Td7ddhUpyNDt0DM/LKXc2/7TaGmac=
Message-ID: <503e0f9d0602272023x4628208cv5d9845b79ed90ae5@mail.gmail.com>
Date: Tue, 28 Feb 2006 09:53:14 +0530
From: "tim tim" <tictactoe.tim@gmail.com>
To: netfilter@lists.netfilter.org
Subject: packet-data
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hello.. i know how to capture a packet using netfilter hook.. i even
succeeded in getting the source and destination adderss of the
captured packet. but i was unable to retrive data from the packet .. 
i came to know that there are pointers to access it . but can anybody
plz show me an example to access data.. thanks in advance.
