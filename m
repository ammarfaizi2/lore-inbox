Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272453AbTHOX4J (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 19:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272469AbTHOX4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 19:56:09 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:34322
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S272453AbTHOXye (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 19:54:34 -0400
Date: Fri, 15 Aug 2003 16:54:31 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Con Kolivas <kernel@kolivas.org>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
Subject: Re: Scheduler activations (IIRC) question
Message-ID: <20030815235431.GT1027@matchmail.com>
Mail-Followup-To: Jamie Lokier <jamie@shareable.org>,
	Con Kolivas <kernel@kolivas.org>,
	linux kernel mailing list <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
	gaxt <gaxt@rogers.com>, Mike Galbraith <efault@gmx.de>
References: <200308160149.29834.kernel@kolivas.org> <20030815230312.GD19707@mail.jlokier.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815230312.GD19707@mail.jlokier.co.uk>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 16, 2003 at 12:03:12AM +0100, Jamie Lokier wrote:
> I think it's been done before, under the name "scheduler activations",
> on some other kernel.
> 

Wouldn't futexes help with this?
