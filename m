Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266303AbUGAVyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266303AbUGAVyv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jul 2004 17:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266310AbUGAVyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jul 2004 17:54:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59304 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266303AbUGAVyq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jul 2004 17:54:46 -0400
Message-ID: <40E48817.3060901@pobox.com>
Date: Thu, 01 Jul 2004 17:54:31 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fabio Coatti <cova@ferrara.linux.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: SATA problems in 2.6.7-mm[1,5] vanilla works
References: <200407012352.16816.cova@ferrara.linux.it>
In-Reply-To: <200407012352.16816.cova@ferrara.linux.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fabio Coatti wrote:
> I'm having problems with sata starting from 2.6.7-mm1: 
> the system hangs at boot, during the sata bus scan.

does 'acpi=off' fix the problem?


