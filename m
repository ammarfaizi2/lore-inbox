Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263748AbUDVAsx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263748AbUDVAsx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 20:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263754AbUDVAsx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 20:48:53 -0400
Received: from mx1.redhat.com ([66.187.233.31]:41423 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263748AbUDVAsw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 20:48:52 -0400
Date: Wed, 21 Apr 2004 20:47:55 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: "David S. Miller" <davem@redhat.com>, Jeff Garzik <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Large inlines in include/linux/skbuff.h
In-Reply-To: <200404212226.28350.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Xine.LNX.4.44.0404212046490.20483-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Apr 2004, Denis Vlasenko wrote:

> What shall be done with this? I'll make patch to move locking functions
> into net/core/skbuff.c unless there is some reason not to do it.

How will these changes impact performance?  I asked this last time you 
posted about inlines and didn't see any response.



- James
-- 
James Morris
<jmorris@redhat.com>


