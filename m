Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261333AbVDBVsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261333AbVDBVsx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 16:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDBVj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 16:39:27 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:40681 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261290AbVDBVfa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 16:35:30 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11.6 (x86_64) Scsi-detect Oops
Date: Sat, 2 Apr 2005 22:35:21 +0100
User-Agent: KMail/1.7.2
References: <200504022010.01454.andrew@walrond.org>
In-Reply-To: <200504022010.01454.andrew@walrond.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504022235.21308.andrew@walrond.org>
X-Spam-Score: -4.8 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 April 2005 20:10, Andrew Walrond wrote:
>
> In the meantime, I'm going to remove this driver from the .config
>

Boots fine without this driver compiled in (SCSI_FUTURE_DOMAIN=n)

Andrew Walrond
