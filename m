Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752036AbWG1QY7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752036AbWG1QY7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 12:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751989AbWG1QY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 12:24:59 -0400
Received: from gateway-1237.mvista.com ([63.81.120.158]:625 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1752035AbWG1QY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 12:24:58 -0400
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector
	feature
From: Daniel Walker <dwalker@mvista.com>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
In-Reply-To: <1154102627.6416.13.camel@laptopd505.fenrus.org>
References: <1154102546.6416.9.camel@laptopd505.fenrus.org>
	 <1154102627.6416.13.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Fri, 28 Jul 2006 09:24:55 -0700
Message-Id: <1154103895.18669.5.camel@c-67-188-28-158.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-07-28 at 18:03 +0200, Arjan van de Ven wrote:

> ---
>  arch/x86_64/Kconfig |   25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)

Could this be supported on more than just x86_64, it seems fairly
generic ? 

Daniel

