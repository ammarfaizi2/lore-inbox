Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbUCKMOM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Mar 2004 07:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261203AbUCKMOM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Mar 2004 07:14:12 -0500
Received: from viefep19-int.chello.at ([213.46.255.28]:57639 "EHLO
	viefep19-int.chello.at") by vger.kernel.org with ESMTP
	id S261197AbUCKMOL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Mar 2004 07:14:11 -0500
Message-ID: <40505810.1070407@freemail.hu>
Date: Thu, 11 Mar 2004 13:14:08 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu; rv:1.6) Gecko/20040115
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: x86_64 IOMMU question
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

is it possible to use the IOMMU to help 32 bit devices
that limit their capabilities with pci_set_dma_mask()?
E.g. the emu10k1 limits itself under 256MB. Can the IOMMU
pass the data to/from the card from/to above 256MB?

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.
