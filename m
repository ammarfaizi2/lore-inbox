Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751294AbVLNH1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751294AbVLNH1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 02:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751296AbVLNH1H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 02:27:07 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:46841 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751294AbVLNH1G convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 02:27:06 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=tRA1V1IXzuHGEd+0sLURl678uAwVNPPEMcAe8//1taPFK1wdDfSOFb2zUcUa13h6CCkjtuC0Ab4VQfBEsh5Zv0ZVUiJEo60olA/9wkz77JD4cJ/38XCKtPo/F2Z5PVAfq1nyBuYxdnxIvyHyACJrNChRDgtofOMhFWQxOlyFgzs=
Message-ID: <f69849430512132327h74949755sa1d646bb0d4ad5b5@mail.gmail.com>
Date: Tue, 13 Dec 2005 23:27:05 -0800
From: kernel coder <lhrkernelcoder@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: ENDEC port and MII interface
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi,
    I'm trying to write ethernet driver.I need some explaination on
ENDEC port and MII interface.By googling i've come to know that MII is
used for phy communication by modern ethernet cards,but i haven't
found much info on  ENDEC ports.

Actually mine card has option to select ENDEC port or MII interface
for transmit and recieve.

Please tell me  which one should i choose and why.

lhrkernelcode
