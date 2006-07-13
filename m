Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030316AbWGMTxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030316AbWGMTxE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 15:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030331AbWGMTxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 15:53:04 -0400
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:33953 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S1030316AbWGMTxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 15:53:03 -0400
Message-ID: <44B6A4A2.2070401@namesys.com>
Date: Thu, 13 Jul 2006 12:53:06 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Reiserfs mail-list <Reiserfs-List@namesys.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: short term task list for Reiser4
References: <44B42064.4070802@namesys.com> <Pine.LNX.4.64.0607131215310.28976@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0607131215310.28976@schroedinger.engr.sgi.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>Will there be any NUMA /SMP fixes? Reiserfs performance is severely 
>impacted at higher processor counts by the mandatory centralized locking 
>in both read and write paths in the filesystem.
>
>
>  
>
Reiserfs or Reiser4?
