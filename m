Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbTDJTXS (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 15:23:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263290AbTDJTXS (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 15:23:18 -0400
Received: from vitelus.com ([64.81.243.207]:31505 "EHLO vitelus.com")
	by vger.kernel.org with ESMTP id S262906AbTDJTXR (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 15:23:17 -0400
Date: Thu, 10 Apr 2003 12:34:20 -0700
From: Aaron Lehmann <aaronl@vitelus.com>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Grzegorz Jaskiewicz <gj@pointblue.com.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: ATAPI cdrecord issue 2.5.67
Message-ID: <20030410193420.GD429@vitelus.com>
References: <1049983308.888.5.camel@gregs> <1049984188.887.11.camel@gregs> <1049986391.599.6.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049986391.599.6.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 10, 2003 at 04:53:11PM +0200, Felipe Alfaro Solana wrote:
> ide-scsi is still broken in 2.5... don't know if it's gonna get fixed or
> deprecated as ATAPI support is working.

I don't like ide-scsi, but I need to use cdrdao to burn vcds. I wish
someone would patch it to support 2.5.x ATAPI.
