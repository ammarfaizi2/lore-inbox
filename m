Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964907AbVKVLx4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964907AbVKVLx4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 06:53:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964922AbVKVLx4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 06:53:56 -0500
Received: from anubis.fi.muni.cz ([147.251.54.96]:60585 "EHLO
	anubis.fi.muni.cz") by vger.kernel.org with ESMTP id S964907AbVKVLxz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 06:53:55 -0500
Date: Tue, 22 Nov 2005 12:52:25 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: linux-kernel@vger.kernel.org
Subject: ioscheduler and 2.6 kernels
Message-ID: <20051122115225.GA2529@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have a question about ioschedulers in current 2.6 kernels. Is there an option
to build iorequest queues per process? I would like to have the queue for each
process and pick up request in round robin manner, which results in more
interactive environment. 

-- 
Luká¹ Hejtmánek
