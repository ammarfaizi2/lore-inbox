Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265983AbUAVIZk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 03:25:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266006AbUAVIZL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 03:25:11 -0500
Received: from catv-5062a04e.szolcatv.broadband.hu ([80.98.160.78]:53123 "EHLO
	catv-5062a04e.szolcatv.broadband.hu") by vger.kernel.org with ESMTP
	id S265983AbUAVIYU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 03:24:20 -0500
Message-ID: <400F88B1.1090002@freemail.hu>
Date: Thu, 22 Jan 2004 09:24:17 +0100
From: Boszormenyi Zoltan <zboszor@freemail.hu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; hu-HU; rv:1.4.1) Gecko/20031114
X-Accept-Language: hu, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Linux-2.6.1-mm4/5 dies booting on an Athlon64
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

mainboard is MSI K8T Neo, Athlon64 3200+.
It does not boot successfully without the "nolapic"
option. "noapic" does not make any difference, "nolapic" does.
Kernel is compiled on a 32bit Fedora,
K7/Athlon and Hammer/Opteron/Athlon64
are selected under CPU support.

-- 
Best regards,
Zoltán Böszörményi

---------------------
What did Hussein say about his knife?
One in Bush worth two in the hand.

