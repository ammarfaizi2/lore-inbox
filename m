Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266350AbUGJSzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266350AbUGJSzl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 14:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266348AbUGJSzl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 14:55:41 -0400
Received: from host84.200-117-131.telecom.net.ar ([200.117.131.84]:54215 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S266349AbUGJSzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 14:55:37 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: Chris Wedgwood <cw@f00f.org>
Subject: Re: XFS: how to NOT null files on fsck?
Date: Sat, 10 Jul 2004 15:55:26 -0300
User-Agent: KMail/1.6.2
Cc: Jan Knutar <jk-lkml@sci.fi>, L A Walsh <lkml@tlinx.org>,
       linux-kernel@vger.kernel.org
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org>
In-Reply-To: <20040710184601.GB5014@taniwha.stupidest.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407101555.27278.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:
> XFS does not journal data.

I think we all know that. The point, why the hell does it null files?
