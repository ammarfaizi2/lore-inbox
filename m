Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263058AbVCEHyV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263058AbVCEHyV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 02:54:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262774AbVCEHyV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 02:54:21 -0500
Received: from mail1.kontent.de ([81.88.34.36]:30647 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S263105AbVCEHxY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 02:53:24 -0500
From: Oliver Neukum <oliver@neukum.org>
To: Rene Rebe <rene@exactcode.de>
Subject: Re: The never ending hpusbscsi storry
Date: Sat, 5 Mar 2005 08:53:37 +0100
User-Agent: KMail/1.7.1
Cc: Matthias Kindtner <matthias.kindtner@t-online.de>,
       sane-devel <sane-devel@lists.alioth.debian.org>,
       linux-kernel@vger.kernel.org
References: <200503050010.04190.matthias.kindtner@t-online.de> <4228EF0B.7030604@exactcode.de>
In-Reply-To: <4228EF0B.7030604@exactcode.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200503050853.37226.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 5. März 2005 00:28 schrieb Rene Rebe:
> Don't ever use hpusbscsi. I though I already told all vedors it is that 
> broken that they should never ever ship it. It is the first thing that 
> will be removed in Linux 2.7.
> 
> If it would be me it would be removed from _all kernels right now_ ...

It shall be. A patch to do that is in the queue. The other users have
gone away.

	Regards
		Oliver
