Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263972AbUDGSBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 14:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264079AbUDGSBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 14:01:25 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:36047 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S263972AbUDGSBY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 14:01:24 -0400
Date: Wed, 07 Apr 2004 11:12:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [patch 0/3] memory hotplug prototype
Message-ID: <29700000.1081361575@flay>
In-Reply-To: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
References: <20040406105353.9BDE8705DE@sv1.valinux.co.jp>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This is an updated version of memory hotplug prototype patch, which I
> have posted here several times.

I really, really suggest you take a look at Dave McCracken's work, which
he posted as "Basic nonlinear for x86" recently. It's going to be much
much easier to use this abstraction than creating 1000s of zones ...

M.

