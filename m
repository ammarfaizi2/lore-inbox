Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270493AbTGaV7o (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 17:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270508AbTGaV7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 17:59:43 -0400
Received: from law11-f124.law11.hotmail.com ([64.4.17.124]:42768 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S270493AbTGaV7k
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 17:59:40 -0400
X-Originating-IP: [216.33.229.163]
X-Originating-Email: [muthian_s@hotmail.com]
From: "Muthian S" <muthian_s@hotmail.com>
To: linux-kernel@vger.kernel.org
Subject: madvise on file pages
Date: Thu, 31 Jul 2003 21:59:39 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law11-F124d2VqKwRPQ00000a39@hotmail.com>
X-OriginalArrivalTime: 31 Jul 2003 21:59:39.0694 (UTC) FILETIME=[0A1AFCE0:01C357AF]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Could someone inform as to what is the behavior when madvise DONTNEED is 
called on pages that are mmap'd from local files mapped with MAP_SHARED, 
i.e. they share the same page that the file cache does.  In such cases, can 
madvise be made to release specific pages in the file cache by mmap-ing the 
relevant file segment ?

thanks,
Muthian.

_________________________________________________________________
Play detective. Identify genuine Windows. 
http://server1.msn.co.in/sp03/coa/index.asp Win cool prizes.

