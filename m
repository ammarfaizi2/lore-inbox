Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262601AbVCPOxK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262601AbVCPOxK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 09:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262608AbVCPOxK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 09:53:10 -0500
Received: from quark.didntduck.org ([69.55.226.66]:56456 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP id S262601AbVCPOxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 09:53:06 -0500
Message-ID: <4238487F.5050708@didntduck.org>
Date: Wed, 16 Mar 2005 09:53:51 -0500
From: Brian Gerst <bgerst@didntduck.org>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: BK snapshots broken
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The snapshots on kernel.org are being created from the most recent tag 
in the BK repo, which is 2.6.11.3.  That means they are missing all of 
the changesets between the 2.6.11 and 2.6.11.3 tags, and don't apply to 
a clean 2.6.11 tree.

--
				Brian Gerst
