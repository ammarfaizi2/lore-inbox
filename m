Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266369AbUBLMDZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 07:03:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266397AbUBLMDZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 07:03:25 -0500
Received: from [212.28.208.94] ([212.28.208.94]:49938 "HELO dewire.com")
	by vger.kernel.org with SMTP id S266369AbUBLMDY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 07:03:24 -0500
From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: JFS default behavior (was: UTF-8 in file systems? xfs/extfs/etc.)
Date: Thu, 12 Feb 2004 13:03:22 +0100
User-Agent: KMail/1.6.1
References: <20040209115852.GB877@schottelius.org> <20040212004532.GB29952@hexapodia.org> <20040212035435.GB19507@pegasys.ws>
In-Reply-To: <20040212035435.GB19507@pegasys.ws>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200402121303.22305.robin.rosenberg.lists@dewire.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 February 2004 04.54, jw schultz wrote:
> For Linux there is no policy except perhaps in userspace.
> It is up to userspace to determine what the policy will be
> regarding charset for filename storage.  Common practice
> seems to be utf-8.

Isn't it is the user's locale, whatever that is? I believe my file names
use ISO-8859-1 (except ntfs, vfat). In northern/western europe 
ISO-8859-1 is common. (Sometimes ISO-8859-15 which for all
practical purposes is backwards compatible with 8859-1). UTF-8 is
gaining terrain though since it is now the default in some distributions
even for Nordic languages (causing big problems for those not
expecting it).

-- robin
