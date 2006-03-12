Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751484AbWCLQ3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbWCLQ3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 11:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751485AbWCLQ3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 11:29:52 -0500
Received: from smtp12.wanadoo.fr ([193.252.22.20]:54007 "EHLO
	smtp12.wanadoo.fr") by vger.kernel.org with ESMTP id S1751484AbWCLQ3u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 11:29:50 -0500
X-ME-UUID: 20060312162949741.B51A81C00087@mwinf1202.wanadoo.fr
Message-ID: <44144C7C.8030704@free.fr>
Date: Sun, 12 Mar 2006 17:29:48 +0100
From: Eric Valette <eric.valette@free.fr>
Reply-To: eric.valette@free.fr
Organization: HOME
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Probable circular dependencies : make bzlilo rebuild nearly everything
 after make bzImage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Started around 2.6.15.3 and is still there in 2.6.16-rc6

-- eric



