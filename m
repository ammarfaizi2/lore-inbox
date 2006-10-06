Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWJFTLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWJFTLn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 15:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932450AbWJFTLn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 15:11:43 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:45324 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1422658AbWJFTLm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 15:11:42 -0400
Date: Fri, 6 Oct 2006 15:11:30 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Ayaz Abdulla <AAbdulla@nvidia.com>
Cc: Alex Owen <r.alex.owen@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: forcedeth net driver: reverse mac address after pxe boot
Message-ID: <20061006191115.GA21526@tuxdriver.com>
References: <55c223960610060737p1a5fda6bl95547accc7d96468@mail.gmail.com> <DBFABB80F7FD3143A911F9E6CFD477B0189CAB16@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B0189CAB16@hqemmail02.nvidia.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2006 at 10:29:04AM -0700, Ayaz Abdulla wrote:
> This has been fixed in version "243.0537". You will have to request an
> updated BIOS from your board vendor.

Ayaz,

Can you explain the whole "reverse-order MAC address" thing?
Why/how does it end-up in that register backwards in the first place?
Does it serve some purpose that way?  Or is it just a bug that we
have to live with?

John
-- 
John W. Linville
linville@tuxdriver.com
