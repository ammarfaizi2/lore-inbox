Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265267AbUGMOic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265267AbUGMOic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jul 2004 10:38:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265268AbUGMOic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jul 2004 10:38:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41189 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265267AbUGMOib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jul 2004 10:38:31 -0400
Message-ID: <40F3F3D1.5090705@pobox.com>
Date: Tue, 13 Jul 2004 10:38:09 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       sfrench@samba.org
Subject: Re: fix oops in build_wildcard_path_from_dentry
References: <200407130806.i6D86NdD009894@hera.kernel.org>
In-Reply-To: <200407130806.i6D86NdD009894@hera.kernel.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> ChangeSet 1.1819, 2004/07/07 07:27:18-05:00, stevef@steveft21.ltcsamba
> 
> 	fix oops in build_wildcard_path_from_dentry


Would you mind adding a prefix that makes it clear what this changeset 
entry is actually referring to?  My recommendation would be "[CIFS] ".

The casual changelog or bk-commits-head reader has no idea that this 
change (and similar cifs changes from you) is related to CIFS without 
opening the message or extracting the changeset -- which defeats the 
purpose of the changelog/email subject.

	Jeff


