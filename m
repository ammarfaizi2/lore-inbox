Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267278AbTGHM2p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:28:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267277AbTGHM2p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:28:45 -0400
Received: from inergen.sybase.com ([192.138.151.43]:41961 "EHLO
	inergen.sybase.com") by vger.kernel.org with ESMTP id S267279AbTGHM0u
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:26:50 -0400
Date: Tue, 8 Jul 2003 14:41:21 +0200
From: Wim ten Have <wtenhave@sybase.com>
To: suparna@in.ibm.com
Cc: linux-kernel@vger.kernel.org, linux-aio@kvack.org
Subject: Re: Bug fix in AIO initialization
Message-Id: <20030708144121.241749f6.wtenhave@sybase.com>
In-Reply-To: <20030708234326.A2352@in.ibm.com>
References: <41F331DBE1178346A6F30D7CF124B24B2A4880@fmsmsx409.fm.intel.com>
	<20030708115345.5e6e5bbc.wtenhave@sybase.com>
	<20030708234326.A2352@in.ibm.com>
Reply-To: wtenhave@sybase.com
Organization: Sybase Inc.
X-Mailer: Sylpheed version 0.8.5 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Jul 2003 23:43:26 +0530
Suparna Bhattacharya <suparna@in.ibm.com> wrote:

> Is this with vanilla 2.5 kernels or recent -mm kernels ?

  vanilla 2.5 kernels

> Are you doing async O_DIRECT reads/writes or regular filesystem
> aio read/writes ?

  both.

-- 
-- Wim ten Have. 		AUDIX: 245 2981
Phone: (+31) 346 582981, Fax: Euro (+31) 346 552884, Room (+31) 346 558415
