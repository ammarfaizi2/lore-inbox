Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266569AbUHOKPo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266569AbUHOKPo (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 06:15:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266572AbUHOKPo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 06:15:44 -0400
Received: from mx1.redhat.com ([66.187.233.31]:61321 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266569AbUHOKPm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 06:15:42 -0400
Message-ID: <411F37CC.3020909@redhat.com>
Date: Sun, 15 Aug 2004 00:15:40 -1000
From: Warren Togami <wtogami@redhat.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040805)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Merge I2O patches from -mm
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a request to please merge the I2O patches currently in Andrew 
Morton's -mm tree into the mainline kernel.  They resolve all known 
reported issues with I2O RAID devices.  If they can be included soon, it 
would be possible to implement and test direct installation before FC3 
Test2 freeze.

Also because Markus would never ask himself, I nominate Markus Lidel as 
the "maintainer" of the 2.6 generic I2O layer.  He has put a tremendous 
amount of work into improving an otherwise neglected part of the kernel. 
  Thanks to his efforts it is today usable and stable on multiple archs 
and all known supported cards.

Thank you,
Warren Togami
wtogami@redhat.com
