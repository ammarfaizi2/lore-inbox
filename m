Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262260AbUC1KP4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 05:15:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUC1KPz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 05:15:55 -0500
Received: from sea1-f108.sea1.hotmail.com ([207.68.163.108]:5903 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S262260AbUC1KPy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 05:15:54 -0500
X-Originating-IP: [203.152.107.104]
X-Originating-Email: [s_kieu@hotmail.com]
From: "Steve Kieu" <s_kieu@hotmail.com>
To: maxime@tralhalla.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: vmware and kernel 2.6 high cpu usage
Date: Sun, 28 Mar 2004 22:15:51 +1200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Sea1-F108LM2ViWLEkY000116a9@hotmail.com>
X-OriginalArrivalTime: 28 Mar 2004 10:15:51.0708 (UTC) FILETIME=[A5D16DC0:01C414AD]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

>
>can you try changing the value of HZ from 1000 to 100 like in a 2.4
>kernel? I bet this is it. Thanks,
>

yes it is fixed. Thanks. I reduce to 100 ; and try to notice the difference 
when running with 1000 for others apps, at first things seems to be a bit 
better (in general)

best regards,

_________________________________________________________________
Listen to music online with the Xtra Broadband Channel  
http://xtra.co.nz/broadband

