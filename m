Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964799AbWFMXcT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964799AbWFMXcT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 19:32:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964801AbWFMXcT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 19:32:19 -0400
Received: from lanshark.nersc.gov ([128.55.16.114]:53916 "EHLO
	lanshark.nersc.gov") by vger.kernel.org with ESMTP id S964799AbWFMXcS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 19:32:18 -0400
Message-ID: <401ACA49.8070002@lbl.gov>
Date: Fri, 30 Jan 2004 13:19:05 -0800
From: Thomas Davis <tadavis@lbl.gov>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: lkml <linux-kernel@vger.kernel.org>
Subject: Athlon CPU detection/fixup is broken in 2.6.2-rc2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I looked in the Changelog - who changed it?

It doesn't work on my dual athlon 2200 MP system - kills it dead.

I can get 2.6.2-rc1 to boot.

thomas

