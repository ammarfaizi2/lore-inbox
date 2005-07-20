Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261409AbVGTRB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261409AbVGTRB4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Jul 2005 13:01:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261414AbVGTRB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Jul 2005 13:01:56 -0400
Received: from prato.iplannetworks.net ([200.69.193.98]:55723 "EHLO
	proxy2.iplannetworks.net") by vger.kernel.org with ESMTP
	id S261409AbVGTRBz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Jul 2005 13:01:55 -0400
Message-ID: <42DE83F7.3010203@latinsourcetech.com>
Date: Wed, 20 Jul 2005 14:03:51 -0300
From: =?ISO-8859-1?Q?M=E1rcio_Oliveira?= <moliveira@latinsourcetech.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Memory Management Question
References: <42DE4D2B.9090503@latinsourcetech.com> <1121865874.3606.13.camel@localhost.localdomain> <42DE5E7C.6060709@latinsourcetech.com>
In-Reply-To: <42DE5E7C.6060709@latinsourcetech.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Is HugeTBL proc memory parameters only to hugetlbfs "filesystem" or are 
these parameters affect ramfs, shm and tmpfs too?

What is the basic difference between ramfs, hugetlbfs, shm and tmpfs to 
the memory management / process VLM utilization?

thanks,

Márcio.
