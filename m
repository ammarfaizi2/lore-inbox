Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262343AbTEMXnb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 19:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262347AbTEMXnb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 19:43:31 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:34567 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S262343AbTEMXna (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 19:43:30 -0400
Date: Tue, 13 May 2003 16:51:50 -0700
From: Andrew Morton <akpm@digeo.com>
To: Clemens Schwaighofer <cs@tequila.co.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Missing disc io stats in /proc/stat in 2.5.69?
Message-Id: <20030513165150.1adf4bb9.akpm@digeo.com>
In-Reply-To: <3EC0A303.5050902@tequila.co.jp>
References: <3EC0A303.5050902@tequila.co.jp>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 May 2003 23:56:11.0787 (UTC) FILETIME=[3B1575B0:01C319AB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clemens Schwaighofer <cs@tequila.co.jp> wrote:
>
> just a more general question. Did the Disc IO stats disappear from
> /proc/stat in 2.5.69? Or do I have to activated them somehow?

/proc/diskstats should be in its final form now.  You'll have to make
guesses about what it contains pending Rick's penmanship.
