Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261908AbVC1QB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261908AbVC1QB3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 11:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261911AbVC1QB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 11:01:29 -0500
Received: from stat16.steeleye.com ([209.192.50.48]:15057 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261908AbVC1QB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 11:01:27 -0500
Subject: Re: [2.6 patch] SCSI: cleanups
From: James Bottomley <James.Bottomley@SteelEye.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Adrian Bunk <bunk@stusta.de>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1112023757.6003.27.camel@laptopd505.fenrus.org>
References: <20050327202139.GQ4285@stusta.de>
	 <1112023305.5531.2.camel@mulgrave>
	 <1112023757.6003.27.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Mon, 28 Mar 2005 10:00:17 -0600
Message-Id: <1112025617.5531.16.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-03-28 at 17:29 +0200, Arjan van de Ven wrote:
> how about a CONFIG_SCSI_DRIVER_DEBUG ?

In principle, that's fine ... in practice does the few bytes saved by
this really justify adding yet another option?

James


