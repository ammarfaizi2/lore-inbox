Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932144AbWIVKtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932144AbWIVKtg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Sep 2006 06:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWIVKtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Sep 2006 06:49:36 -0400
Received: from dtp.xs4all.nl ([80.126.206.180]:38318 "HELO abra2.bitwizard.nl")
	by vger.kernel.org with SMTP id S932144AbWIVKtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Sep 2006 06:49:36 -0400
Date: Fri, 22 Sep 2006 12:49:34 +0200
From: Erik Mouw <erik@harddisk-recovery.com>
To: Frederik Deweerdt <deweerdt@free.fr>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: Make kernel -dirty naming optional
Message-ID: <20060922104933.GA3348@harddisk-recovery.com>
References: <20060922120210.GA957@slug>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060922120210.GA957@slug>
Organization: Harddisk-recovery.com
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2006 at 12:02:10PM +0000, Frederik Deweerdt wrote:
> Could you consider applying this patch (or indicate me a better way to
> do it). It can be handy to be able to keep the naming independent of
> git.

FWIW, if I enable git name tagging, every kernel I compile is tagged as
"dirty", even if I cloned it directly from kernel.org and didn't make
any change to the source. That makes the "dirty" tag useless IMHO.


Erik

-- 
+-- Erik Mouw -- www.harddisk-recovery.com -- +31 70 370 12 90 --
| Lab address: Delftechpark 26, 2628 XH, Delft, The Netherlands
