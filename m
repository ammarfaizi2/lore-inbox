Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261851AbTDHPrK (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261857AbTDHPrK (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 11:47:10 -0400
Received: from zeke.inet.com ([199.171.211.198]:41366 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S261851AbTDHPrK (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 11:47:10 -0400
Message-ID: <3E92F1AC.6040502@inet.com>
Date: Tue, 08 Apr 2003 10:58:36 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: pcnet32 - noncoherent arches?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

All,

I'm trying to get pcnet32 working on a board.  The driver appears to 
work without problems on x86, but on my noncoherent board, I have a 
number of issues.  I still need to narrow them down a bit, but I was 
wondering if anyone here had tried to use this driver on a noncoherent arch?

TIA,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

