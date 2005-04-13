Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261303AbVDMPwd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261303AbVDMPwd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Apr 2005 11:52:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261378AbVDMPwd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Apr 2005 11:52:33 -0400
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:38843 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S261303AbVDMPwa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Apr 2005 11:52:30 -0400
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [Crosspost] GNU/Linux userland?
Date: Wed, 13 Apr 2005 16:52:11 +0100
User-Agent: KMail/1.7.2
Cc: Oliver Korpilla <Oliver.Korpilla@gmx.de>
References: <425D75AF.7080802@gmx.de>
In-Reply-To: <425D75AF.7080802@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504131652.11151.andrew@walrond.org>
X-Spam-Score: -4.9 (----)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 April 2005 20:40, Oliver Korpilla wrote:
> Hello!
>
> I wondered if there is a project or setup that does allow me to build a
> GNU/Linux userland including kernel, build environment, basic tools with
> a single script just as you can in NetBSD (build.sh) or FreeBSD (make
> world).
>
> I do not refer to a step-by-step instruction like "Linux From Scratch"
> (which I do find commendable, but is not quite the same), but an
> automated, cross-compilation aware foundation for a Linux system.
>

Heretix does everything except cross-compile. It's a complete rewrite of rubyx 
(http://www.rubyx.org) but doesn't have its own website yet. Discussion is 
happening on the rubyx ML. Cross compilation support would be a simple 
extension to Heretix, if you fancy a project :)

Andrew Walrond
