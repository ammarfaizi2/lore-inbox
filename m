Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262394AbTANLVq>; Tue, 14 Jan 2003 06:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262395AbTANLVq>; Tue, 14 Jan 2003 06:21:46 -0500
Received: from holomorphy.com ([66.224.33.161]:50309 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S262394AbTANLVp>;
	Tue, 14 Jan 2003 06:21:45 -0500
Date: Tue, 14 Jan 2003 03:30:36 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: anyone have a 16-bit x86 early_printk?
Message-ID: <20030114113036.GG940@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying to get a box to boot and it appears to drop dead before
start_kernel(). Would anyone happen to have an early_printk() analogue
for 16-bit x86 code?


Thanks,
Bill
