Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750732AbWDTF75@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750732AbWDTF75 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 01:59:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWDTF75
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 01:59:57 -0400
Received: from mail7.sea5.speakeasy.net ([69.17.117.9]:63117 "EHLO
	mail7.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750732AbWDTF74 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 01:59:56 -0400
Date: Thu, 20 Apr 2006 01:59:51 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Antti Halonen <antti.halonen@secgo.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: RE: searching exported symbols from modules
In-Reply-To: <963E9E15184E2648A8BBE83CF91F5FAF5154F0@titanium.secgo.net>
Message-ID: <Pine.LNX.4.64.0604200159170.10447@d.namei>
References: <963E9E15184E2648A8BBE83CF91F5FAF5154F0@titanium.secgo.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2006, Antti Halonen wrote:

> > > Exactly, I agree 100%. But here's the catch: it's not an option at
> this
> > > point in time.
> > 
> > eh why not? For your module to be ever merged into mainline this
> change
> > will need to be done anyway (and it'll save you time as well even on
> the
> > short term)
> 
> This is commercial module and will not be merged into mainline.

Is it GPL or compatible?



- James
-- 
James Morris
<jmorris@namei.org>
