Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265676AbUFCRmb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265676AbUFCRmb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 13:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFCRks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 13:40:48 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:743 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S264411AbUFCRkE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 13:40:04 -0400
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: Zoltan.Menyhart@bull.net
Subject: Re: Who owns those locks ?
Date: Thu, 3 Jun 2004 11:39:58 -0600
User-Agent: KMail/1.6.2
Cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
References: <40A1F4BE.4A298352@nospam.org>
In-Reply-To: <40A1F4BE.4A298352@nospam.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406031139.58964.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 May 2004 3:56 am, Zoltan Menyhart wrote:
> Got a dead lock ?
> No idea how you got there ?
> 
> Why don't you put the ID of the owner of the lock in the lock word ?
> Here is your patch for IA-64.
> Doesn't cost any additional instruction, you can have it in your
> "production" kernel, too.

Whatever happened with this patch?  I really like the idea, but
it seems like it died on the vine.  Maybe it's time to clean it
up, pull all the bits together, and repost it.
