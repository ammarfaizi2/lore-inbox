Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTENWR0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 18:17:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTENWR0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 18:17:26 -0400
Received: from siaab1aa.compuserve.com ([149.174.40.1]:21414 "EHLO
	siaab1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S262976AbTENWRZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 18:17:25 -0400
Date: Wed, 14 May 2003 18:26:10 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] 2.5.68 FUTEX support should be optional
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200305141829_MC3-1-38F1-59C7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hpa wrote:

> How about creating a master option like we have for experimental?
> Something like "Allow removal of essential components?" (CONFIG_EMBEDDED)

  ...and that just enables another option: "REALLY allow removal of
essential components?" (CONFIG_REALLY_EMBEDDED)

 :)


