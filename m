Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262488AbVBCAEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262488AbVBCAEx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 19:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262790AbVBBXvO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 18:51:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:34484 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262645AbVBBXrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 18:47:17 -0500
Date: Wed, 2 Feb 2005 18:47:10 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Fruhwirth Clemens <clemens@endorphin.org>
cc: Andrew Morton <akpm@osdl.org>, <linux-kernel@vger.kernel.org>,
       <michal@logix.cz>, "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 01/04] Adding cipher mode context information to crypto_tfm
In-Reply-To: <Xine.LNX.4.44.0502021842140.5331-100000@thoron.boston.redhat.com>
Message-ID: <Xine.LNX.4.44.0502021846390.5331-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Feb 2005, James Morris wrote:

> Correct, although I think this will get lost in the noise given that it's 
> sitting in the middle of crypto processing.  I'd remove it.

Dave just ok'd it, so take his advice over mine :-)


- james
-- 
James Morris
<jmorris@redhat.com>


