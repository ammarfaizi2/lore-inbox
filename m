Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030322AbWFUV4y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030322AbWFUV4y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 17:56:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWFUV4y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 17:56:54 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:46263 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030322AbWFUV4x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 17:56:53 -0400
Date: Wed, 21 Jun 2006 14:56:49 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Jeff Dike <jdike@addtoit.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: UML/x86_64 broke on debian etch
In-Reply-To: <20060621215539.GA7270@ccure.user-mode-linux.org>
Message-ID: <Pine.LNX.4.64.0606211456050.22515@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0606211345030.21866@schroedinger.engr.sgi.com>
 <20060621215539.GA7270@ccure.user-mode-linux.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jun 2006, Jeff Dike wrote:

> Did you start with a defconfig?

No I did "make mrproper" and then "make menuconfig ARCH=um"

