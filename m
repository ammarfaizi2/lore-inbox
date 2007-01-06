Return-Path: <linux-kernel-owner+w=401wt.eu-S932178AbXAFUqL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932178AbXAFUqL (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 15:46:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932186AbXAFUqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 15:46:10 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:48990 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932178AbXAFUqK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 15:46:10 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45A00A8B.2030804@s5r6.in-berlin.de>
Date: Sat, 06 Jan 2007 21:46:03 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.8) Gecko/20061202 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Tim Schmielau <tim@physik3.uni-rostock.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3 regression?  hdparm shows 1/2...1/3 the throughput
References: <459FE2AF.2020507@s5r6.in-berlin.de> <Pine.LNX.4.63.0701062018530.29044@gockel.physik3.uni-rostock.de> <459FFE95.1020403@s5r6.in-berlin.de>
In-Reply-To: <459FFE95.1020403@s5r6.in-berlin.de>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Tim Schmielau wrote:
>> See
>>   http://lkml.org/lkml/2007/1/2/75
>> for the solution.

OK; this has already been committed a few days ago. I assume this closes
the issue. I will post after -rc4 in the unlikely case that it doesn't.
-- 
Stefan Richter
-=====-=-=== ---= --==-
http://arcgraph.de/sr/
