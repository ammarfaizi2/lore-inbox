Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262073AbVG0KaR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbVG0KaR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 06:30:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262189AbVG0KaR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 06:30:17 -0400
Received: from ahriman.Bucharest.roedu.net ([141.85.128.71]:52228 "EHLO
	ahriman.bucharest.roedu.net") by vger.kernel.org with ESMTP
	id S262073AbVG0KaP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 06:30:15 -0400
Date: Wed, 27 Jul 2005 13:30:36 +0300
From: Mihai Rusu <dizzy@roedu.net>
To: Howard Chu <hyc@highlandsun.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12.3 network slowdown?
Message-ID: <20050727103036.GA14948@ahriman.roedu.net>
References: <1122452018.772579.63900@g49g2000cwa.googlegroups.com> <20050727082020.C73AC5F7CA@attila.bofh.it> <42E7497B.5040202@highlandsun.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42E7497B.5040202@highlandsun.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2005 at 01:44:43AM -0700, Howard Chu wrote:
> I just recently compiled the 2.6.12.3 kernel for my x86_64 machine
> (Asus A8V motherboard); was previously running a SuSE-compiled 2.6.8
> kernel (SuSE 9.2 distro). I'm now seeing extremely slow throughput on
> the onboard Yukon (Marvell) ethernet interface, but only in certain
> conditions. Going back to the 2.6.8 kernel shows no slowdown.

You might try the other SysKonnect driver as 2.6.12 ships with 2 
different drivers for this family of NICs.

> -- 
>   -- Howard Chu
>   Chief Architect, Symas Corp.  http://www.symas.com
>   Director, Highland Sun        http://highlandsun.com/hyc
>   OpenLDAP Core Team            http://www.openldap.org/project/

-- 
Mihai RUSU                                    Email: dizzy@roedu.net
GPG : http://dizzy.roedu.net/dizzy-gpg.txt    WWW: http://dizzy.roedu.net
                       "Linux is obsolete" -- AST
