Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750862AbWHGAqX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750862AbWHGAqX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 20:46:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750863AbWHGAqX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 20:46:23 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:62520 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1750861AbWHGAqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 20:46:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=O9Lo9dzg2YOBYzT79ai2v6Q4VaiVackCphldpMQpg6ElJdEA76Ol6v2MoUoH6HANQaJU9ggTLQhNby/2RJ2DLh8tWea/hLFuZ6v0gU+dQBTSwb5hDZa6VqcFrbQFat6BKhFuNNPDCFRa25WgCXzQ15E/4IFgCU9qt69wUyZnBUY=
Message-ID: <abcd72470608061746o2810f895n9f9979f99c00d273@mail.gmail.com>
Date: Sun, 6 Aug 2006 17:46:21 -0700
From: "Avinash Ramanath" <avinashr@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Stat in kernel space
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could somebody let me know which function equivalent/header file is
available in kernel space for "stat"ing?
I want an equivalent of stat/lstat/fstat in kernel space.

Thanks,
Avinash.
