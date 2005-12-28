Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964779AbVL1JcV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964779AbVL1JcV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Dec 2005 04:32:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932520AbVL1JcV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Dec 2005 04:32:21 -0500
Received: from zproxy.gmail.com ([64.233.162.195]:44348 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932509AbVL1JcU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Dec 2005 04:32:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Nydg1BHFZ4VmXXY2znKpYmcQZ3oFglgQVruymPPYIfdW0S1+Mj4/rmdV5kWCfIu9vUmgA9TyZLeoLQQ0JIC/QW7KdaQZCHNeA5nhDjLrkz3DRmrC1KF/w6Stg0MVE0ZJdTKG6zqVOTDZHR1N2LUzt0qoct4tFKgAogseSMgfvFQ=
Message-ID: <7a37e95e0512280132m59d9c333wf8d27c1dc5f85fee@mail.gmail.com>
Date: Wed, 28 Dec 2005 15:02:19 +0530
From: Deven Balani <devenbalani@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: scatter-gather with ping-ponging
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Does any one know to source to implement a scatter-gather list
mechanism with ping pong mechanism.
Or in other words,
I want to implement chaning of buffer descriptors with double
buffering mechanism.

It would be helpful for if any one can give _inputs_.

Thanks,
Deven
