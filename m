Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262619AbUCEPOA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Mar 2004 10:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262621AbUCEPOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Mar 2004 10:14:00 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:9920 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S262619AbUCEPN7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Mar 2004 10:13:59 -0500
Subject: Re: Race in nobh_prepare_write
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040305001748.60172d3c.akpm@osdl.org>
References: <1078413178.9164.24.camel@shaggy.austin.ibm.com>
	 <20040305001748.60172d3c.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1078499626.9164.58.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 05 Mar 2004 09:13:46 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-05 at 02:17, Andrew Morton wrote:
> 
> This passes decent testing on 1k blocksize ext2.

So far, I'm seeing no problems with jfs either.
-- 
David Kleikamp
IBM Linux Technology Center

