Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262922AbUBZS43 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 13:56:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbUBZS43
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 13:56:29 -0500
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:39303 "EHLO
	mail8.fw-bc.sony.com") by vger.kernel.org with ESMTP
	id S262922AbUBZS4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 13:56:24 -0500
Message-ID: <403E4363.2070908@am.sony.com>
Date: Thu, 26 Feb 2004 11:05:07 -0800
From: Tim Bird <tim.bird@am.sony.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux kernel <linux-kernel@vger.kernel.org>
Subject: Why no interrupt priorities?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What's the rationale for not supporting interrupt priorities
in the kernel?

We're having a discussion of this in one of our CELF working
groups, and it would help if someone could explain why an
interrupt priority system has never been adopted in the
mainstream Linux kernel. (I know that some implementations
have been written and proposed).

Is there a strong policy against such a thing, or is it just
that the right implementation has not come along?

Thanks,

=============================
Tim Bird
Architecture Group Co-Chair
CE Linux Forum
Senior Staff Engineer
Sony Electronics
E-mail: Tim.Bird@am.sony.com
=============================

