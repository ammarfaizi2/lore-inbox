Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262131AbUCLOGZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 09:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262133AbUCLOGZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 09:06:25 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:6353 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S262131AbUCLOGW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 09:06:22 -0500
From: Christian Borntraeger <kernel@borntraeger.net>
To: linux-kernel@vger.kernel.org
Subject: Re: Unkillable Zombie process under 2.6.3 and 2.6.4
Date: Fri, 12 Mar 2004 15:06:15 +0100
User-Agent: KMail/1.6.1
Cc: David Fort <david.fort@irisa.fr>, Andrew Morton <akpm@osdl.org>
References: <40508D65.9000601@irisa.fr> <20040311151729.57e3d936.akpm@osdl.org> <4051C126.5080902@irisa.fr>
In-Reply-To: <4051C126.5080902@irisa.fr>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200403121506.18236.kernel@borntraeger.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:5a8b66f42810086ecd21595c2d6103b9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Fort wrote:
> I'm trying to build a test app that can trigger the case where GDBed
> process become unkillable zombies

Does it help to send a SIGCONT to all processes in T state?

cheers

Christian
