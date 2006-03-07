Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750950AbWCGIAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750950AbWCGIAa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 03:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752012AbWCGIAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 03:00:30 -0500
Received: from main.gmane.org ([80.91.229.2]:33255 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1750950AbWCGIA3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 03:00:29 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Alex <gaaf@gmx.net>
Subject: Re: modutils
Date: Tue, 07 Mar 2006 08:45:50 +0100
Message-ID: <dujdne$hku$1@sea.gmane.org>
References: <503e0f9d0603022041q717ae7cdo8539ba8f508dd681@mail.gmail.com> <105c793f0603022138u6dca326ewa3b5d476f4c4ef48@mail.gmail.com> <503e0f9d0603022141l5dc9a88ds380dd9dd2ba22c41@mail.gmail.com> <105c793f0603022145t55f25cedpd6c40efd703530f5@mail.gmail.com> <503e0f9d0603022155j2570314jffcdf84060e336f2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: waxy.kabel.utwente.nl
User-Agent: KNode/0.10.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

tim tim wrote:

> okayy let me give a breif explanatin of what i am doing..
> 
> here i am trying to install 2.6.10 kernel on the system that was fully
> installed RedHat EL3 (2.4.21). we followed this procedure..
> 
> make xconfig and selected loadable modules support along with the
> filesystem (ext3) support.
> 
> then make bzImage
> make modules

Isn't a 'make install' missing here?
 
> so far it works fine  and
> make modules_install
> 
> it tries to install some .. modules .. after that it prints like..

<snip>


Alex.

