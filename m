Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262018AbTERLY7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 07:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262019AbTERLY7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 07:24:59 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:46853 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S262018AbTERLY6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 07:24:58 -0400
Date: Sun, 18 May 2003 13:36:34 +0200
To: Diego Calleja =?iso-8859-1?Q?Garc=EDa?= <diegocg@teleline.es>
Cc: Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.5.69-mm6
Message-ID: <20030518113634.GA3446@hh.idb.hist.no>
References: <20030516015407.2768b570.akpm@digeo.com> <20030518000644.74e8e3e8.diegocg@teleline.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030518000644.74e8e3e8.diegocg@teleline.es>
User-Agent: Mutt/1.5.4i
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 12:06:44AM +0200, Diego Calleja García wrote:
> I had this oops don't know how it happened (not reproduceable):
> 
<...>
I also had a 2.5.69-mm6 freeze.  No dump since it happened
while running X, and no disk activity were possible afterwards.
No emergency sync, just the sysrq+B.
This was UP with preempt.

Helge Hafting


