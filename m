Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262600AbUCJMib (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Mar 2004 07:38:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbUCJMia
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Mar 2004 07:38:30 -0500
Received: from piggy.rz.tu-ilmenau.de ([141.24.4.8]:47491 "EHLO
	piggy.rz.tu-ilmenau.de") by vger.kernel.org with ESMTP
	id S262600AbUCJMg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Mar 2004 07:36:27 -0500
Date: Wed, 10 Mar 2004 13:36:17 +0100
From: "Mario 'BitKoenig' Holbe" <Mario.Holbe@RZ.TU-Ilmenau.DE>
To: Bruce Allen <ballen@gravity.phys.uwm.edu>
Cc: Henrik Persson <nix@syndicalist.net>, linux-kernel@vger.kernel.org
Subject: Re: Strange DMA-errors and system hang with Promise 20268
Message-ID: <20040310123616.GA31893@darkside.22.kls.lan>
Mail-Followup-To: Mario 'BitKoenig' Holbe <Mario.Holbe@RZ.TU-Ilmenau.DE>,
	Bruce Allen <ballen@gravity.phys.uwm.edu>,
	Henrik Persson <nix@syndicalist.net>, linux-kernel@vger.kernel.org
References: <1078752642.1239.14.camel@vega> <Pine.GSO.4.21.0403100547430.8400-100000@dirac.phys.uwm.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0403100547430.8400-100000@dirac.phys.uwm.edu>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 10, 2004 at 05:50:12AM -0600, Bruce Allen wrote:
> Does the disk's SMART error log (smartctl -l error) show any entries
> related to this problem?  If so, please print them with the latest version

No, none at all. This was the first I was looking at, because
I just thought it was some disk problem.


regards,
   Mario
-- 
"Why are we hiding from the police, daddy?"      | J. E. Guenther
"Because we use SuSE son, they use SYSVR4."      | de.alt.sysadmin.recovery
