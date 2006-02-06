Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750753AbWBFIW4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750753AbWBFIW4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 03:22:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWBFIWz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 03:22:55 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:1730 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1750753AbWBFIWy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 03:22:54 -0500
Date: Mon, 6 Feb 2006 00:22:36 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: akpm@osdl.org, dgc@sgi.com, steiner@sgi.com, Simon.Derr@bull.net,
       ak@suse.de, linux-kernel@vger.kernel.org, clameter@sgi.com
Subject: Re: [PATCH 1/5] cpuset memory spread basic implementation
Message-Id: <20060206002236.29d902f7.pj@sgi.com>
In-Reply-To: <20060206073938.GA24366@elte.hu>
References: <20060204071910.10021.8437.sendpatchset@jackhammer.engr.sgi.com>
	<20060205203711.2c855971.akpm@osdl.org>
	<20060205225629.5d887661.pj@sgi.com>
	<20060205230816.4ae6b6e2.akpm@osdl.org>
	<20060206073938.GA24366@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo wrote:
> Modifying hundreds 
> of apps, some of which might be legacy, seems impractical - and the 
> access pattern might very much depend on the project it is used in.

Well said.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
