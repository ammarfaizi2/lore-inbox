Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751409AbWFTQ6S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbWFTQ6S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jun 2006 12:58:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWFTQ6S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jun 2006 12:58:18 -0400
Received: from nz-out-0102.google.com ([64.233.162.203]:5165 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750779AbWFTQ6R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jun 2006 12:58:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=QkN1T7xt+nP2nbCjPZHzV9RtlMV03k/TXR+YXZR1T5VoeSoXeU+17O7fSVml4B9ldP7g/l4C3aoFylRS0R54WRmyqPMH8ihv3ArOVNzcrbxMIILcBAYucsBuKunQehfPUXBHcpRiDcqD6Mr4lXaXuHxRoxo1e2Jg5U6FaR9qi4c=
Message-ID: <7f45d9390606200958t15a04eefhf61c11335c005259@mail.gmail.com>
Date: Tue, 20 Jun 2006 10:58:16 -0600
From: "Shaun Jackman" <sjackman@gmail.com>
Reply-To: "Shaun Jackman" <sjackman@gmail.com>
To: LKML <linux-kernel@vger.kernel.org>
Subject: ioctl to enable/disable an RS485 termination resistor
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a custom RS485 serial device that allows the termination
resistor to be enabled/disabled using a relay. When writing the driver
for this device, how should I choose the ioctl name/number to set the
RS485 termination parameter?

Please cc me in your reply. Many thanks,
Shaun
