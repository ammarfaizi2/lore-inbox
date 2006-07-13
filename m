Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWGMEsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWGMEsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 00:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932502AbWGMEsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 00:48:23 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:18864 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932501AbWGMEsX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 00:48:23 -0400
Date: Thu, 13 Jul 2006 00:43:42 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: oops during rsync
To: Paul Paquette <paulp@bowes.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607130045_MC3-1-C4D4-AC62@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44B5452B.4070503@bowes.com>


On Wed, 12 Jul 2006 14:53:31 -0400, Paul Paquette wrote:

> Below is the oops, then the kernel config and system map.

> ...

> Call Trace:
>  [<c0162b68>] dquot_drop+0x35/0x68

Is that the whole trace?  It should be longer and there should be a Code:
line as well.

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
