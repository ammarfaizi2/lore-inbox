Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264024AbTDOBXC (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 21:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbTDOBXB (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 21:23:01 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:20610 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP id S264024AbTDOBXB (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 21:23:01 -0400
Date: Mon, 14 Apr 2003 18:34:47 -0700
To: Andrew Morton <akpm@digeo.com>
Cc: rudmer@legolas.dynup.net, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.5.67-mm3
Message-ID: <20030415013447.GA3592@gnuppy.monkey.org>
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030414110326.GA19003@gnuppy.monkey.org> <200304141707.45601@gandalf> <20030415010328.GA3299@gnuppy.monkey.org> <20030414181302.0da41360.akpm@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030414181302.0da41360.akpm@digeo.com>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 06:13:02PM -0700, Andrew Morton wrote:
> Could be anything.   Does sysrq not work?
> 
> If not, please send me your .config.

It does it with elevator=deadline too. I'll see if I can get you better
dump.

bill

