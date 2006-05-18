Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWERWdM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWERWdM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 18:33:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750843AbWERWdM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 18:33:12 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:53149 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1750740AbWERWdL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 18:33:11 -0400
Message-ID: <446CF65A.6040006@cmu.edu>
Date: Thu, 18 May 2006 18:34:02 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.2 (X11/20060503)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: how to view dmesg during initrd?
References: <446CD6C1.6030705@cmu.edu>
In-Reply-To: <446CD6C1.6030705@cmu.edu>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to load a module with initrd and insmod, however insmod
simply says "unresolved external symbols!" and puts the rest in dmesg,
is there any way to find out these symbols if my kernel panics, and
never boots, therefore i can't see the dmesg?

Thanks!
George
