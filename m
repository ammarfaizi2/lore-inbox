Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261355AbVDSPsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261355AbVDSPsq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Apr 2005 11:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDSPsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Apr 2005 11:48:46 -0400
Received: from wproxy.gmail.com ([64.233.184.205]:20698 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261355AbVDSPsp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Apr 2005 11:48:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Ul/vRNRKIT+KPxvMGxPlBuBxYSFeB8CNddTsCPRXl8kb6zxrroPyLxPwX/juHpb1J5A66oLLqCqwY1dFwq70zc/8zUILdZOJPb7IrPkhcjxjr/hidCEIQyYn6wSv++goHqP7OA6wkK6oi8ImTJ915HDJSOr6hyp0HFnUa3fNQR8=
Message-ID: <875fe4a5050419084873ae8db1@mail.gmail.com>
Date: Tue, 19 Apr 2005 15:48:45 +0000
From: Francesco Oppedisano <francesco.oppedisano@gmail.com>
Reply-To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: DMA transfer
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
when i NIC writes a packet in memory using a DMA transaction, can i be
sure that this transaction will tranfer the entire frame or it is
possible to have frame fragmentation with every fragment beeing
transferred in a separate DMA transaction?

Thank u very much

Francesco Oppedisano
