Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261581AbVFHTyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261581AbVFHTyr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 15:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261584AbVFHTyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 15:54:47 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:55719
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S261582AbVFHTyh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 15:54:37 -0400
Date: Wed, 08 Jun 2005 12:54:19 -0700 (PDT)
Message-Id: <20050608.125419.18305230.davem@davemloft.net>
To: davej@redhat.com
Cc: jketreno@linux.intel.com, vda@ilport.com.ua, pavel@ucw.cz,
       jgarzik@pobox.com, netdev@oss.sgi.com, linux-kernel@vger.kernel.org,
       ipw2100-admin@linux.intel.com
Subject: Re: ipw2100: firmware problem
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20050608194902.GK876@redhat.com>
References: <42A7268D.9020402@linux.intel.com>
	<20050608.124332.85408883.davem@davemloft.net>
	<20050608194902.GK876@redhat.com>
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Wed, 8 Jun 2005 15:49:02 -0400

> FWIW, I agree, though the licensing of the Intel firmware
> prevents that iirc.  The biggest problem I face with this driver
> in Fedora kernels is users mismatching firmware rev with the
> driver version. Another problem that disappears if the two
> are shipped together.

Yep, this license definitely hurts users, in many many ways.

If this kind of external firmware requirement existed for a popular
SCSI controller, more people would be up in arms about this and
understand the issue more clearly.
