Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262505AbVEMTZR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262505AbVEMTZR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 15:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262490AbVEMTWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 15:22:46 -0400
Received: from mail.dvmed.net ([216.237.124.58]:63702 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S262505AbVEMTRH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 15:17:07 -0400
Message-ID: <4284FD2C.8080109@pobox.com>
Date: Fri, 13 May 2005 15:17:00 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Benjamin LaHaise <bcrl@kvack.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: [rfc/patch] libata -- port configurable delays
References: <20050513185850.GA5777@kvack.org>
In-Reply-To: <20050513185850.GA5777@kvack.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Of course, the real solution is to get a modern controller like AHCI or 
SiI 3124, which don't require banging on the Status register -- an 
ultimately pointless, completely emulated operation in SATA.

:)

	Jeff



