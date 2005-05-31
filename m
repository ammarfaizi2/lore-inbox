Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVEaUe1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVEaUe1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 16:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVEaUe1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 16:34:27 -0400
Received: from kiln.isn.net ([198.167.161.1]:60859 "EHLO kiln.isn.net")
	by vger.kernel.org with ESMTP id S261437AbVEaUbS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 16:31:18 -0400
Message-ID: <429CC990.1050005@isn.net>
Date: Tue, 31 May 2005 15:31:12 -0500
From: "Garst R. Reese" <garstr@isn.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: SPI
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attn: Randy Dunlap,
It means Serial Peripheral Interface. Among other things it is one of 
the modes of talking to MMC & SD cards, some LCD's, D/As etc. There may 
be code in the SD09 SD055 drivers. It is a 3 or 4 wire interface -- clk, 
in, out, and optional extra thing that I don't recall.  I think it runs 
up to about 25Mbits/s.

(not subscribed)

Garst
