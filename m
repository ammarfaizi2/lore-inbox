Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261447AbVAMAu2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261447AbVAMAu2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 19:50:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261472AbVAMAuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 19:50:21 -0500
Received: from smtp3.akamai.com ([63.116.109.25]:15785 "EHLO smtp3.akamai.com")
	by vger.kernel.org with ESMTP id S261431AbVAMAsd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 19:48:33 -0500
Message-ID: <41E5C638.6F1A00AA@akamai.com>
Date: Wed, 12 Jan 2005 16:52:08 -0800
From: Prasanna Meda <pmeda@akamai.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.16-3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] file_table:expand_files() code cleanup
References: <200501121550.HAA02069@allur.sanmateo.akamai.com> <20050112161606.334c4bfe.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

> May as well lose that FDSET_DEBUG code as well - if someone wants to debug
> this code they can type in their own printk's, no?

Yes,  can delete it. I just copied.

