Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbUD1U25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbUD1U25 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:28:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUD1U0X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:26:23 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:4274 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262003AbUD1UXP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:23:15 -0400
Message-ID: <409012A4.9000502@pobox.com>
Date: Wed, 28 Apr 2004 16:23:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Neal D. Becker" <ndbecker2@verizon.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: State of linux checkpointing?
References: <c6oorn$3dq$1@sea.gmane.org>
In-Reply-To: <c6oorn$3dq$1@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Neal D. Becker wrote:
> I wonder if there is a checkpointing that will work with 2.6 kernels?
> 
> I only need relatively basic checkpointing.  No sockets or fancy stuff.


You only need checkpointing when your application programmers are lazy 
and don't care about data integrity.  :)

	Jeff



