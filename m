Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262418AbUFGJM1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262418AbUFGJM1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jun 2004 05:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264352AbUFGJM1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jun 2004 05:12:27 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:17033 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S262418AbUFGJM0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jun 2004 05:12:26 -0400
Date: Mon, 7 Jun 2004 10:12:06 +0100
From: Dave Jones <davej@redhat.com>
To: Timothy Webster <timothyw@outblaze.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Porting cpqhealth to v2.6
Message-ID: <20040607091206.GA3040@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Timothy Webster <timothyw@outblaze.com>,
	linux-kernel@vger.kernel.org
References: <20040607083809.14677.qmail@team.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040607083809.14677.qmail@team.outblaze.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 07, 2004 at 04:38:09PM +0800, Timothy Webster wrote:

 > The driver source is available from 
 > ftp.compaq.com/pub/products/servers/supportsoftware/linux/ 
 > hpasm-7.1.0-xx.xxx.i386.rpm 

This isn't driver source, but a binary object + wrapper.
You could port the wrapper, but who knows if it'll work or not..

		Dave

