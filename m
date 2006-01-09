Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964802AbWAIPkR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964802AbWAIPkR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 10:40:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964805AbWAIPkR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 10:40:17 -0500
Received: from mail3.sea5.speakeasy.net ([69.17.117.5]:60048 "EHLO
	mail3.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S964802AbWAIPkP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 10:40:15 -0500
Date: Mon, 9 Jan 2006 10:40:18 -0500 (EST)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Andreas Gruenbacher <agruen@suse.de>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [patch 1/2] Generic infrastructure for acls
In-Reply-To: <20060108231235.273553000@blunzn.suse.de>
Message-ID: <Pine.LNX.4.63.0601091039540.2886@excalibur.intercode>
References: <20060108230116.073177000@blunzn.suse.de> <20060108231235.273553000@blunzn.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jan 2006, Andreas Gruenbacher wrote:

> Add some infrastructure for access control lists on in-memory
> filesystems such as tmpfs.
> 
> Signed-off-by: Andreas Gruenbacher <agruen@suse.de>

Acked-by: James Morris <jmorris@namei.org>



- James
-- 
James Morris
<jmorris@namei.org>
