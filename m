Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161223AbWJYRlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161223AbWJYRlg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 13:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161227AbWJYRlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 13:41:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35299 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161223AbWJYRlf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 13:41:35 -0400
Date: Wed, 25 Oct 2006 10:41:28 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: What about make mergeconfig ?
In-Reply-To: <1161755164.22582.60.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0610251040410.8586@schroedinger.engr.sgi.com>
References: <1161755164.22582.60.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2006, Benjamin Herrenschmidt wrote:

> The idea here is that on archs like powerpc, we have the ability to
> build kernels that can boot several platforms. However, the defconfigs
> we ship (g5_defconfig, pseries_defconfig, maple_defconfig, cell... ) are
> tailored for one platform.

Same issue on IA64. Would be good to have.
