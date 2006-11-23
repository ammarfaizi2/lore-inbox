Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755518AbWKWKOU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755518AbWKWKOU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 05:14:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757328AbWKWKOU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 05:14:20 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:10188 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S1755518AbWKWKOT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 05:14:19 -0500
Message-ID: <4565747A.5010208@s5r6.in-berlin.de>
Date: Thu, 23 Nov 2006 11:14:18 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: Burman Yan <yan_952@hotmail.com>
CC: linux-kernel@vger.kernel.org, trivial@kernel.org
Subject: Re: [PATCH 2.6.19-rc5] i386: replace kmalloc+memset with kzalloc
References: <BAY20-F2488E0B821BA4687F5F6FCD8E30@phx.gbl>
In-Reply-To: <BAY20-F2488E0B821BA4687F5F6FCD8E30@phx.gbl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Burman Yan wrote:
> This patch replaces kmalloc+memset with kzalloc in i386 arch files

Send patches inline. Or if you and only have access to a MUA which
reformats inline text but have an urgent patch, send as attachment in
7bit ASCII encoding, typed as text/plain or text/x-patch.

All the patches you sent were encoded in base64 and typed as
application/octet-stream, thus totally useless on a mailinglist.
-- 
Stefan Richter
-=====-=-==- =-== =-===
http://arcgraph.de/sr/
