Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262848AbTJULes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 07:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263015AbTJULes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 07:34:48 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:42187 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S262848AbTJULer (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 07:34:47 -0400
Date: Tue, 21 Oct 2003 13:34:44 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test8] Difference between Software Suspend and Suspend-to-disk?
Message-ID: <20031021113444.GC9887@louise.pinerecords.com>
References: <200310211315.58585.lkml@kcore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200310211315.58585.lkml@kcore.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct-21 2003, Tue, 13:15 +0200
Jan De Luyck <lkml@kcore.org> wrote:

> Software Suspend (EXPERIMENTAL)
> Suspend-to-Disk Support

They're competing implementations of the same mechanism.

-- 
Tomas Szepe <szepe@pinerecords.com>
