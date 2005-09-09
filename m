Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932495AbVIIIEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932495AbVIIIEV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 04:04:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVIIIEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 04:04:21 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31170 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S1751441AbVIIIET (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 04:04:19 -0400
Date: Fri, 9 Sep 2005 01:04:10 -0700
From: Paul Jackson <pj@sgi.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: tony.luck@intel.com, sam@ravnborg.org, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] Consistently use the name asm-offsets.h
Message-Id: <20050909010410.1cefe27f.pj@sgi.com>
In-Reply-To: <4320B69D.5010901@didntduck.org>
References: <B8E391BBE9FE384DAA4C5C003888BE6F0456EE9E@scsmsx401.amr.corp.intel.com>
	<4320B69D.5010901@didntduck.org>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian wrote:
> The right fix is to get rid of that god-awful circular dependency on 
> offset.h

Just try making such a patch.  I double triple dare you.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
