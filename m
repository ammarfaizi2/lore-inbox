Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751709AbWFKB3Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709AbWFKB3Z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jun 2006 21:29:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750902AbWFKB3Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jun 2006 21:29:25 -0400
Received: from py-out-1112.google.com ([64.233.166.179]:11594 "EHLO
	py-out-1112.google.com") by vger.kernel.org with ESMTP
	id S1750804AbWFKB3Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jun 2006 21:29:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=pUJmdiQ3L5yrNqpOxiRiL+NHQD44lRSqfd96LdHF7wzCHVP95FAimuKYOJHzspkrJmZBw/gHoFw8Z9Gnm4sdVCUIiNfwDEeVcnKFsV3bzqCZGmYLMDht4E6jvrf0z47Prfco/uxVvd+VLxxoGu2C3E4S4JKQJO1xWToBsgt8gAU=
Message-ID: <e7aeb7c60606101829k796576e7u4247f14cdce7d791@mail.gmail.com>
Date: Sun, 11 Jun 2006 03:29:24 +0200
From: "Yitzchak Eidus" <ieidus@gmail.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: does linux support copy on write page table entries?
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

does linux support copy on write page table entries?
and if it doesnt , how faster can it make the kernel create new process?
