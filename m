Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269318AbUINOZY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269318AbUINOZY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Sep 2004 10:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269328AbUINOZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Sep 2004 10:25:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:27287 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269318AbUINOZK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Sep 2004 10:25:10 -0400
Date: Tue, 14 Sep 2004 10:24:48 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: David Howells <dhowells@redhat.com>
cc: Andrew Morton <akpm@osdl.org>, <jamesm@redhat.com>,
       Nikita Danilov <nikita@clusterfs.com>, <rjw@sisk.pl>, <ak@suse.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.9-rc1-mm5 
In-Reply-To: <13185.1095168073@redhat.com>
Message-ID: <Xine.LNX.4.44.0409141020470.24898-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Sep 2004, David Howells wrote:

> > David, what do you want it renamed to?
> 
> key_struct? token? key_token?
> 
> Possibly ticket or principal, though they make it sound like it's specifically
> for Kerberos, so perhaps not.

Then there's the related problem of what do do about the naming of 
key_alloc(), key.h etc.

What about 'akey', where a is for authentication or access.


- James
-- 
James Morris
<jmorris@redhat.com>



