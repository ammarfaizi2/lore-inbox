Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261301AbULHSBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbULHSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 13:01:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULHR7r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:59:47 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:36832 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261303AbULHR6B
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:58:01 -0500
Subject: Re: Figuring out physical memory regions from a kernel module
From: Dave Hansen <haveblue@us.ibm.com>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C20596010F@azsmsx406>
References: <C863B68032DED14E8EBA9F71EB8FE4C20596010F@azsmsx406>
Content-Type: text/plain
Message-Id: <1102528665.25546.981.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 08 Dec 2004 09:57:46 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 09:44, Hanson, Jonathan M wrote:
> 	Is there a reliable way to tell from a kernel module (currently
> written for 2.4 but will need to work under 2.6 in the future) which
> regions of physical memory are actually available for the kernel and
> processes to use?

Is this a rehashing of the "Walking all the physical memory in an x86
system" thread? :)

Why don't you just tell us what you're actually trying to do in your
module.  There's probably a better way.

-- Dave

