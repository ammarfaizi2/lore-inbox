Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263702AbUDMTm6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:42:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263709AbUDMTm6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:42:58 -0400
Received: from herkules.viasys.com ([194.100.28.129]:40149 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S263702AbUDMTm5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:42:57 -0400
Date: Tue, 13 Apr 2004 22:42:51 +0300
From: Ville Herva <vherva@viasys.com>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
Cc: Guillaume =?iso-8859-1?Q?Lac=F4te?= <Guillaume@lacote.name>,
       linux-kernel@vger.kernel.org, Linux@glacote.com
Subject: Re: Using compression before encryption in device-mapper
Message-ID: <20040413194251.GQ23361@viasys.com>
Reply-To: vherva@viasys.com
References: <200404131744.40098.Guillaume@Lacote.name> <20040413174516.GB1084@wohnheim.fh-wedel.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040413174516.GB1084@wohnheim.fh-wedel.de>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2+mremap-unmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 13, 2004 at 07:45:16PM +0200, you [Jörn Engel] wrote:
> 
> Yes, on the filesystems level.  Jffs2 is usable, although not well-suited
> for disks and similar, ext2compr appears to be unusable. 

Quite the opposite: e2compr on 2.2.x (and 2.0 as far as I can remember) is
very stable. The 2.4 port wasn't usable in my testing, though.


-- v -- 

v@iki.fi

