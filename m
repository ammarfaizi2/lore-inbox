Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269170AbUINDxN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269170AbUINDxN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 23:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268328AbUINDvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 23:51:04 -0400
Received: from holomorphy.com ([207.189.100.168]:45200 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S269179AbUINDuz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 23:50:55 -0400
Date: Mon, 13 Sep 2004 20:50:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Chris Wright <chrisw@osdl.org>, kronos@kronoz.cjb.net,
       linux-kernel <linux-kernel@vger.kernel.org>, joq@io.com, torbenh@gmx.de
Subject: Re: [PATCH] Realtime LSM
Message-ID: <20040914035039.GY9106@holomorphy.com>
References: <20040912155035.GA17972@dreamland.darkstar.lan> <1095117752.1360.5.camel@krustophenia.net> <20040913163448.T1973@build.pdx.osdl.net> <1095128285.1752.4.camel@krustophenia.net> <20040914030126.GV9106@holomorphy.com> <1095133574.1752.9.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1095133574.1752.9.camel@krustophenia.net>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-09-13 at 23:01, William Lee Irwin III wrote:
>> Please construct a entitlement/permission checking scheme for this that
>> is not so lax as removing permissions checks altogether conditionally
>> on some sysctl.

On Mon, Sep 13, 2004 at 11:46:14PM -0400, Lee Revell wrote:
> This is how it works now.  You would typically do 'modprobe realtime
> gid=29' and add audio users to that group.  How is this any less secure
> than the traditional user/group/other permissions model?

I have no issue with uid/gid checks, thanks for clarifying.


-- wli
