Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932389AbVJMUDW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932389AbVJMUDW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Oct 2005 16:03:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932392AbVJMUDW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Oct 2005 16:03:22 -0400
Received: from mail28.sea5.speakeasy.net ([69.17.117.30]:43465 "EHLO
	mail28.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S932389AbVJMUDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Oct 2005 16:03:21 -0400
Date: Thu, 13 Oct 2005 16:03:19 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Jesper Juhl <jesper.juhl@gmail.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       David Howells <dhowells@redhat.com>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [PATCH 12/14] Big kfree NULL check cleanup - security
In-Reply-To: <200510132130.10463.jesper.juhl@gmail.com>
Message-ID: <Pine.LNX.4.63.0510131603040.12890@excalibur.intercode>
References: <200510132130.10463.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Oct 2005, Jesper Juhl wrote:

> This is the security/ part of the big kfree cleanup patch.
> 
> Remove pointless checks for NULL prior to calling kfree() in security/.
> 
> 
> Sorry about the long Cc: list, but I wanted to make sure I included everyone
> who's code I've changed with this patch.
> 
> 
> Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>

Acked-by: James Morris <jmorris@namei.org>

-- 
James Morris
<jmorris@namei.org>
