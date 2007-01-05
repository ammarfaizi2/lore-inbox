Return-Path: <linux-kernel-owner+w=401wt.eu-S965118AbXAEA7o@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965118AbXAEA7o (ORCPT <rfc822;w@1wt.eu>);
	Thu, 4 Jan 2007 19:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965132AbXAEA7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Jan 2007 19:59:44 -0500
Received: from smtp0.osdl.org ([65.172.181.24]:40837 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965118AbXAEA7n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Jan 2007 19:59:43 -0500
Date: Thu, 4 Jan 2007 16:59:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Justin Rosander <myrddinemrys@neo.rr.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: PROBLEM: LSIFC909 mpt card fails to recognize devices
Message-Id: <20070104165922.137c6df9.akpm@osdl.org>
In-Reply-To: <1167955606.5133.13.camel@localhost>
References: <1167955606.5133.13.camel@localhost>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Jan 2007 19:06:46 -0500
Justin Rosander <myrddinemrys@neo.rr.com> wrote:

> Please forward this to the appropriate maintainer.  Thank you.
> 
> [1.] One line summary of the problem:    My fibre channel drives fail to
> be recognized by my LSIFC909 card. 

Please send the output of `lspci -vn'
