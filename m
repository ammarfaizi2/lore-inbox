Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266096AbUFDXYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266096AbUFDXYT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266083AbUFDXXD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:23:03 -0400
Received: from mx1.redhat.com ([66.187.233.31]:47514 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266061AbUFDXVi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:21:38 -0400
Date: Fri, 4 Jun 2004 19:21:30 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Clay Haapala <chaapala@cisco.com>
cc: "David S. Miller" <davem@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Crypto digests and kmapping sg entries larger than a page, with
 [PATCH]
In-Reply-To: <yquj7junkviw.fsf@chaapala-lnx2.cisco.com>
Message-ID: <Xine.LNX.4.44.0406041921180.14838-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jun 2004, Clay Haapala wrote:

> He supplies a patch, below.
> 
> If you agree with the implementation, I'll re-diff and test against a
> recent BitKeeper extract and submit a patch.

Thanks, please do so.


- James
-- 
James Morris
<jmorris@redhat.com>


