Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266127AbUIVPFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266127AbUIVPFu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Sep 2004 11:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266128AbUIVPFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Sep 2004 11:05:50 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:53260 "EHLO
	kinesis.swishmail.com") by vger.kernel.org with ESMTP
	id S266127AbUIVPFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Sep 2004 11:05:49 -0400
Message-ID: <41519691.6010006@techsource.com>
Date: Wed, 22 Sep 2004 11:13:21 -0400
From: Timothy Miller <miller@techsource.com>
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Popping/Crackling on via82xx, ALSA
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just wanted to mention that the problems I was having with my sound 
seem to have gone away.

The two things that contributed to fixing the problem:

- Enabling ACPI
- Upgrading from 2.6.7 to 2.6.8

Thanks, all!

