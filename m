Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261310AbVAWOxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261310AbVAWOxr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jan 2005 09:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbVAWOxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jan 2005 09:53:47 -0500
Received: from ra.tuxdriver.com ([24.172.12.4]:776 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S261310AbVAWOxo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jan 2005 09:53:44 -0500
Date: Sun, 23 Jan 2005 09:51:37 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [patch 2.4.29] i810_audio: use MMIO for systems that support it
Message-ID: <20050123145137.GB28932@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	marcelo.tosatti@cyclades.com
References: <20050120214608.GE7687@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050120214608.GE7687@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2005 at 04:46:09PM -0500, John W. Linville wrote:
> Use MMIO accesses for devices that support it.  This also enables
> MMIO-only configurations.

Please hold-off on applying this patch...I'm going to repost this
patch with a related patch shortly.

John
-- 
John W. Linville
linville@tuxdriver.com
