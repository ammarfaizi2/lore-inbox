Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265329AbTLRVqt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 16:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265336AbTLRVqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 16:46:49 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:3748 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265329AbTLRVqr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 16:46:47 -0500
Message-ID: <3FE2203A.7090608@pobox.com>
Date: Thu, 18 Dec 2003 16:46:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frederic Rossi <frederic.rossi@ericsson.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] AEM v0.5.3 on kernel 2.6.0
References: <16354.4831.508501.934390@localhost.localdomain>
In-Reply-To: <16354.4831.508501.934390@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederic Rossi wrote:
> 
> AEM (Asynchronous Event Mechanism) is an extension providing a native 
> support for asynchronous events in the Linux kernel. 


The kernel already supports this, via netlink.

	Jeff



