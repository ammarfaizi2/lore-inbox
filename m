Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbTAZBJj>; Sat, 25 Jan 2003 20:09:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266615AbTAZBJj>; Sat, 25 Jan 2003 20:09:39 -0500
Received: from hughes-fe01.direcway.com ([66.82.20.91]:7811 "EHLO
	hughes-fe01.direcway.com") by vger.kernel.org with ESMTP
	id <S266564AbTAZBJh>; Sat, 25 Jan 2003 20:09:37 -0500
Subject: Re: 2.5.59-mm5 hangs on boot
From: Tom Sightler <ttsig@tuxyturvy.com>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20030125165953.44e1b655.akpm@digeo.com>
References: <1043534331.1672.71.camel@iso-2146-l1.zeusinc.com>
	<20030125153217.6ff6e275.akpm@digeo.com>
	<1043542198.3019.4.camel@iso-2146-l1.zeusinc.com> 
	<20030125165953.44e1b655.akpm@digeo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 25 Jan 2003 20:18:33 -0500
Message-Id: <1043543924.3021.14.camel@iso-2146-l1.zeusinc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-01-25 at 19:59, Andrew Morton wrote:
> OK, thanks.  Not sure what to suggest at present.  Maybe when Luuk has done
> the patch iteration and we've fixed whatever is causing his boot failure we
> can then move on.
> 
> Are you using RAID at all?

No RAID.  Just a basic laptop with a 30GB IDE drive and IDE CDRW/DVDR
using an Intel chipset.  I just checked my config and multi-device
support is not even enabled.

Later,
Tom


