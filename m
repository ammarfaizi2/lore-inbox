Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264020AbTDOAvn (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 20:51:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264022AbTDOAvn (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 20:51:43 -0400
Received: from wsip68-15-8-100.sd.sd.cox.net ([68.15.8.100]:17026 "EHLO
	gnuppy.monkey.org") by vger.kernel.org with ESMTP id S264020AbTDOAvm (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 20:51:42 -0400
Date: Mon, 14 Apr 2003 18:03:28 -0700
To: Rudmer van Dijk <rudmer@legolas.dynup.net>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, "Bill Huey (Hui)" <billh@gnuppy.monkey.org>
Subject: Re: 2.5.67-mm3
Message-ID: <20030415010328.GA3299@gnuppy.monkey.org>
References: <20030414015313.4f6333ad.akpm@digeo.com> <20030414110326.GA19003@gnuppy.monkey.org> <200304141707.45601@gandalf>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304141707.45601@gandalf>
User-Agent: Mutt/1.5.4i
From: Bill Huey (Hui) <billh@gnuppy.monkey.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 14, 2003 at 05:13:05PM +0200, Rudmer van Dijk wrote:
> this patch fixes it. Maybe it is better to move the call to store_edid up 
> inside the already avilable #ifdef but I'm not sure if that is possible

Now I'm getting console warning "anticipatory scheduler" at boot time
and then having it freeze after mounting root read-only.

bill

