Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263220AbVGAFRl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbVGAFRl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 01:17:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263217AbVGAFRl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 01:17:41 -0400
Received: from smtp1.sloane.cz ([62.240.161.228]:34811 "EHLO smtp1.sloane.cz")
	by vger.kernel.org with ESMTP id S263221AbVGAFRc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 01:17:32 -0400
From: Michal Semler <cijoml@volny.cz>
Reply-To: cijoml@volny.cz
To: linux-kernel@vger.kernel.org
Subject: How to find IRQ errors?
Date: Fri, 1 Jul 2005 07:17:17 +0200
User-Agent: KMail/1.7.2
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507010717.18492.cijoml@volny.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I need to fix driver which causes IRQ errors. Can you pls give me an advice 
where and how to start?

I see in dmesg:

overflow irq (1)
overflow irq (2)
and so on...

I know module which causes it

Thanks for help

Michal
