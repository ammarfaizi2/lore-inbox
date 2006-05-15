Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964976AbWEOPNv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964976AbWEOPNv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 11:13:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964975AbWEOPNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 11:13:51 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:46804 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S964978AbWEOPNu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 11:13:50 -0400
Date: Mon, 15 May 2006 17:13:48 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "sej.kernel" <sej.kernel@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Rlimit
In-Reply-To: <446899A0.1040407@gmail.com>
Message-ID: <Pine.LNX.4.61.0605151713390.28020@yvahk01.tjqt.qr>
References: <446899A0.1040407@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Hello,
> How can I set Rlimit for 1 or more programs started in user mode (not suser) ?
> Is there a config file or a little source that can do this ?
> Regards,
> sej

man setrlimit


Jan Engelhardt
-- 
