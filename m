Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263967AbTE3UAQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 16:00:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263979AbTE3UAQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 16:00:16 -0400
Received: from ip67-95-245-82.z245-95-67.customer.algx.net ([67.95.245.82]:272
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S263967AbTE3UAP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 16:00:15 -0400
Date: Fri, 30 May 2003 13:07:13 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: kupdated in 2.5
Message-ID: <20030530200713.GA25810@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <200305301428.34510.fsdeveloper@yahoo.de> <6ur86gmx28.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6ur86gmx28.fsf@zork.zork.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 30, 2003 at 01:35:43PM +0100, Sean Neakums wrote:
> Michael Buesch <fsdeveloper@yahoo.de> writes:
> 
> > I recognized, that kupdated is no longer present (under that name?)
> > in 2.5.70. (or did I misconfigure something?)
> > I saw it, when i wanted to run noflushd on 2.5.
> > So, what has been changed here? Where can I get more information on it?
> 
> I believe pdflush replaced kupdated in 2.5.

Didn't pdflush (one per processor) replace bdflush?
