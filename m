Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264479AbUFLAzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264479AbUFLAzi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Jun 2004 20:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264499AbUFLAzh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Jun 2004 20:55:37 -0400
Received: from smtp08.auna.com ([62.81.186.18]:10175 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id S264479AbUFLAz0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Jun 2004 20:55:26 -0400
Date: Sat, 12 Jun 2004 02:55:24 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: linux-kernel@vger.kernel.org
Subject: Re: Invalid module format ?
Message-ID: <20040612005524.GA5506@werewolf.able.es>
References: <20040612003846.GA4275@werewolf.able.es> <200406111751.15408.lkml@lpbproductions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <200406111751.15408.lkml@lpbproductions.com> (from lkml@lpbproductions.com on Sat, Jun 12, 2004 at 02:51:15 +0200)
X-Mailer: Balsa 2.0.17
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 06.12, Matt H. wrote:
> J.A. Magallon ,
> 
> Grab the latest offical nvidia driver 5336 , then patch it with the patch 
> aviable from http://www.minion.de/nvidia.html ( there patch allows the nvidia 
> driver to compile and work under gcc 3.4 ). 
> 

I've got that patches ;).
I think the problem is gcc-3.4.1.

Why can a module give that error ?
Any header info, some MODULE_INFO, what ?

werewolf:~> rpm -q module-init-tools
module-init-tools-3.0-2mdk

TIA

--
J.A. Magallon <jamagallon()able!es>     \                 Software is like sex:
werewolf!able!es                         \           It's better when it's free
Mandrakelinux release 10.1 (Cooker) for i586
Linux 2.6.5-rc1-jam3 (gcc 3.4.1 (Mandrakelinux (Cooker) 3.4.1-0.3mdk)) #3
