Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753308AbWKCP6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753308AbWKCP6H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 10:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753309AbWKCP6H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 10:58:07 -0500
Received: from mx1.redhat.com ([66.187.233.31]:51364 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1753308AbWKCP6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 10:58:05 -0500
Date: Fri, 3 Nov 2006 10:56:56 -0500
From: Dave Jones <davej@redhat.com>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Adrian Bunk <bunk@stusta.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Christian <christiand59@web.de>
Subject: Re: [discuss] Linux 2.6.19-rc4: known unfixed regressions (v2)
Message-ID: <20061103155656.GA1000@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>,
	Adrian Bunk <bunk@stusta.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-acpi@vger.kernel.org, Christian <christiand59@web.de>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org> <20061103024132.GG13381@stusta.de> <20061103025623.GB8816@redhat.com> <454AFD01.4080306@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454AFD01.4080306@linux.intel.com>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 03, 2006 at 11:25:37AM +0300, Alexey Starikovskiy wrote:
 > Could this be a problem?
 > --------------------
 > ...
 > CONFIG_ACPI_PROCESSOR=m
 > ...
 > CONFIG_X86_POWERNOW_K8=y

Hmm, possibly.  Christian, does it work again if you set them both to =y ?

	Dave

-- 
http://www.codemonkey.org.uk
