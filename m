Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUJRXlZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUJRXlZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 19:41:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267807AbUJRXlZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 19:41:25 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:3221 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S267841AbUJRXkR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 19:40:17 -0400
Message-ID: <4174543A.1030906@nortelnetworks.com>
Date: Mon, 18 Oct 2004 17:39:38 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: question on memory map cleanup stuff
References: <41744A50.3030700@nortelnetworks.com> <20041018231432.GI5607@holomorphy.com>
In-Reply-To: <20041018231432.GI5607@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

> vma->vm_ops->close() often suffices for such without disturbing the core.

Ah.  That looks promising.

Thanks.

Chris
