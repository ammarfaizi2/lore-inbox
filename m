Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVGQRrA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVGQRrA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 13:47:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVGQRqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 13:46:50 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:29586 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261369AbVGQRpn
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 13:45:43 -0400
Subject: Re: [RFC] [PATCH 0/4]Multiple block allocation and delayed
	allocation for ext3
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: ext2-devel <ext2-devel@lists.sourceforge.net>
Cc: Andrew Morton <akpm@osdl.org>, "Stephen C. Tweedie" <sct@redhat.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-fsdevel@vger.kernel.org, Badari Pulavarty <pbadari@us.ibm.com>,
       suparna@in.ibm.com, tytso@mit.edu, alex@clusterfs.com,
       adilger@clusterfs.com
In-Reply-To: <1121622002.4609.23.camel@localhost.localdomain>
References: <1110839154.24286.302.camel@dyn318077bld.beaverton.ibm.com>
	 <1121622002.4609.23.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM LTC
Date: Sun, 17 Jul 2005 10:45:38 -0700
Message-Id: <1121622338.4609.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2005-07-17 at 10:40 -0700, Mingming Cao wrote:
> Hi All, 
> 
> Here are the updated patches to support multiple block allocation and
> delayed allocation for ext3 done by me, Badari and Suparna.

Patches are against 2.6.13-rc3.


Mingming

