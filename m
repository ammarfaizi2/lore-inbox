Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932676AbWAGAHH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932676AbWAGAHH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 19:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932679AbWAGAHH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 19:07:07 -0500
Received: from rwcrmhc14.comcast.net ([216.148.227.154]:63961 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S932676AbWAGAHF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 19:07:05 -0500
Message-ID: <43BF0629.2030705@namesys.com>
Date: Fri, 06 Jan 2006 16:07:05 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [-mm patch] fs/reiser4/: misc cleanups
References: <20060105223913.GK12313@stusta.de>
In-Reply-To: <20060105223913.GK12313@stusta.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:

>This patch makes some needlessly global code static and #ifdef's some 
>unused code away.
>
>
>Signed-off-by: Adrian Bunk <bunk@stusta.de>
>  
>
Did we lose this patch from our patch process, or is this more cleanups
from you?

If we are losing patches donated to us, then I need to be a manager and
go complain....
