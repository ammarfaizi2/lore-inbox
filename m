Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261936AbVCAPMs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261936AbVCAPMs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Mar 2005 10:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261935AbVCAPMr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Mar 2005 10:12:47 -0500
Received: from mummy.ncsc.mil ([144.51.88.129]:58257 "EHLO jazzhorn.ncsc.mil")
	by vger.kernel.org with ESMTP id S261934AbVCAPMn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Mar 2005 10:12:43 -0500
Subject: Re: [PATCH] SELinux: Leak in error path
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Alexander Nyberg <alexn@dsv.su.se>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, jmorris@redhat.com
In-Reply-To: <1109637172.3839.11.camel@boxen>
References: <1109637172.3839.11.camel@boxen>
Content-Type: text/plain
Organization: National Security Agency
Date: Tue, 01 Mar 2005 10:04:51 -0500
Message-Id: <1109689491.10589.26.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-8) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-03-01 at 01:32 +0100, Alexander Nyberg wrote:
> There's a leak here in the first error path.
> 
> Found by the Coverity tool.
> 
> Signed-off-by: Alexander Nyberg <alexn@dsv.su.se>

Acked-by:  Stephen Smalley <sds@tycho.nsa.gov>

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

