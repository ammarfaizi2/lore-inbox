Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161481AbWJ0DOH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161481AbWJ0DOH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 23:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161480AbWJ0DOG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 23:14:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:11162 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161478AbWJ0DOD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 23:14:03 -0400
Date: Thu, 26 Oct 2006 20:13:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Cc: Jeff Garzik <jeff@garzik.org>, netdev <netdev@vger.kernel.org>,
       Christoph Raisch <raisch@de.ibm.com>,
       "Jan-Bernd Themann" <themann@de.ibm.com>,
       "linux-kernel" <linux-kernel@vger.kernel.org>,
       "linux-ppc" <linuxppc-dev@ozlabs.org>, Marcus Eder <meder@de.ibm.com>,
       Thomas Klein <tklein@de.ibm.com>
Subject: Re: [PATCH 2.6.19-rc3 1/2] ehea: kzalloc GFP_ATOMIC fix
Message-Id: <20061026201313.9c831fc9.akpm@osdl.org>
In-Reply-To: <200610251311.43009.ossthema@de.ibm.com>
References: <200610251311.43009.ossthema@de.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2006 13:11:42 +0200
Jan-Bernd Themann <ossthema@de.ibm.com> wrote:

> This patch fixes kzalloc parameters (GFP_ATOMIC instead of GFP_KERNEL)

why?
