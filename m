Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261283AbULHRur@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261283AbULHRur (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Dec 2004 12:50:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbULHRur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Dec 2004 12:50:47 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13519 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261284AbULHRuf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Dec 2004 12:50:35 -0500
Subject: Re: Figuring out physical memory regions from a kernel module
From: Arjan van de Ven <arjan@infradead.org>
To: "Hanson, Jonathan M" <jonathan.m.hanson@intel.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C863B68032DED14E8EBA9F71EB8FE4C20596010F@azsmsx406>
References: <C863B68032DED14E8EBA9F71EB8FE4C20596010F@azsmsx406>
Content-Type: text/plain
Message-Id: <1102528225.2830.30.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 08 Dec 2004 12:50:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-12-08 at 10:44 -0700, Hanson, Jonathan M wrote:
> 	Is there a reliable way to tell from a kernel module (currently
> written for 2.4 but will need to work under 2.6 in the future) which
> regions of physical memory are actually available for the kernel and
> processes to use? For example, the following command tells me the
> regions of physical memory that are available to use:


ehhh what do you need it for???
without knowing that it's hard to give recommendations

