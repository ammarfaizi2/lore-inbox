Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267378AbUG2AdH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267378AbUG2AdH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 20:33:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267387AbUG2Aat
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 20:30:49 -0400
Received: from mx1.redhat.com ([66.187.233.31]:37021 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267377AbUG2A1T (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 20:27:19 -0400
Date: Wed, 28 Jul 2004 20:27:13 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: David Wagner <daw-usenet@taverner.cs.berkeley.edu>
cc: linux-kernel@vger.kernel.org, Christophe Saout <christophe@saout.de>
Subject: Re: [PATCH] Delete cryptoloop
In-Reply-To: <ce9216$o5o$1@abraham.cs.berkeley.edu>
Message-ID: <Xine.LNX.4.44.0407282025440.12996-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Jul 2004, David Wagner wrote:

> James Morris  wrote:
> >It would be good if we could get some further review on the issue by an 
> >independent, well known cryptographer.
> 
> I'd be glad to review it if someone can point me to a clear, concise
> description of the scheme (trying to extract the spec from the code
> is too much work for me).

That would be great.  It would be best to do this review for dm-crypt.  

Christophe, is there a detailed description of the existing scheme?



- James
-- 
James Morris
<jmorris@redhat.com>


