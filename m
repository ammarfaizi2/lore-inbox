Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUBTV0E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 16:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261410AbUBTV0E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 16:26:04 -0500
Received: from mx1.redhat.com ([66.187.233.31]:60394 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261321AbUBTV0B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 16:26:01 -0500
Date: Fri, 20 Feb 2004 16:26:04 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Jean-Luc Cooke <jlcooke@certainkey.com>
cc: Christophe Saout <christophe@saout.de>,
       Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2004@gmx.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: dm-crypt, new IV and standards
In-Reply-To: <20040220172237.GA9918@certainkey.com>
Message-ID: <Xine.LNX.4.44.0402201624030.7335-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Feb 2004, Jean-Luc Cooke wrote:

> If others on the list care to do this, I'll give recommendation on how to 
> implement the security (hmac, salt, iteration counts, etc).  But I think
> this may break backward compatibility.  Can anyone speak to this?

Please focus your recommendations on security, not backward compatibility
with something that is new to the kernel tree, broken and maintainerless.

Thanks,


- James
-- 
James Morris
<jmorris@redhat.com>


