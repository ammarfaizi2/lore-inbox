Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269942AbUJTKsM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269942AbUJTKsM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:48:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269974AbUJTKnm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:43:42 -0400
Received: from main.gmane.org ([80.91.229.2]:29163 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S269864AbUJTKg6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:36:58 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@mru.ath.cx>
Subject: Re: Versioning of tree
Date: Wed, 20 Oct 2004 12:36:34 +0200
Message-ID: <yw1x3c094qx9.fsf@mru.ath.cx>
References: <1098254970.3223.6.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 197.80-202-92.nextgentel.com
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
Cancel-Lock: sha1:/wCVhGQItKiOiV3l+sJa0dHUBmU=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> Hi Linus !
>
> After you tag a "release" tree in bk, could you bump the version number
> right away, with eventually some junk in EXTRAVERSION like "-devel" ?
>
> It's quite painful to have a module dir name clash between the "clean"
> final tree and whatever dev stuff we are testing out of bk ... it's fine
> once you go to -rc1, but in the meantime, it's really annoying.

I've been thinking of the possibility to automate something like that
using a bk trigger.

-- 
Måns Rullgård
mru@mru.ath.cx

