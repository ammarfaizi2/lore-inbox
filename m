Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266021AbUGNAjs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266021AbUGNAjs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 20:39:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267264AbUGNAjs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 20:39:48 -0400
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:35667 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S266021AbUGNAjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 20:39:48 -0400
Message-ID: <40F47F08.1060402@uindy.edu>
Date: Tue, 13 Jul 2004 19:32:08 -0500
From: "Robert W. Fuller" <fullerrw@uindy.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040601
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: ACPI hang on Compaq 2199US laptop with kernel 2.6.7
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I have ACPI configured for the 2.6.7 kernel, boot hangs after the 
message "ACPI: IRQ9 SCI: Level Trigger."  If I configure the 2.6.7 
kernel without ACPI, everything is fine.

I would like to have ACPI because my laptop does not have APM.  The 
laptop model is a Compaq Presario 2199US.
