Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267869AbUIBIvM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267869AbUIBIvM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 04:51:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267916AbUIBIvM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 04:51:12 -0400
Received: from 209-128-98-078.bayarea.net ([209.128.98.78]:6105 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S267869AbUIBIvL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 04:51:11 -0400
Message-ID: <4136DEF7.7010706@zytor.com>
Date: Thu, 02 Sep 2004 08:51:03 +0000
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.7) Gecko/20040608
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Jan Beulich <JBeulich@novell.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: question on i386 very early memory detection cleanup patch
References: <s136d15f.000@emea1-mh.id2.novell.com>
In-Reply-To: <s136d15f.000@emea1-mh.id2.novell.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich wrote:

> If you refer to the 4G/4G split patch - this isn't part of mainline, and
> if it needs it would seem it should do this adjustment, not an unrelated
> patch. Jan
> 

It is, or at least was, in the -mm tree, however.

	-hpa

