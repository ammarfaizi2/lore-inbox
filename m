Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTETClg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 22:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263510AbTETClg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 22:41:36 -0400
Received: from holomorphy.com ([66.224.33.161]:18923 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263496AbTETClf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 22:41:35 -0400
Date: Mon, 19 May 2003 19:54:10 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Gerald Stuhrberg <grstuhrberg@aaahawk.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: DHCP
Message-ID: <20030520025410.GJ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Gerald Stuhrberg <grstuhrberg@aaahawk.com>,
	linux-kernel@vger.kernel.org
References: <200305191821.h4JILlE12026@adam.yggdrasil.com> <1053398767.22400.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1053398767.22400.8.camel@localhost>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 19, 2003 at 10:46:07PM -0400, Gerald Stuhrberg wrote:
> I was just wondering if anyone had plans to implement a DHCP client in
> the kernel.Something that would listen for an ip that could be loaded as
> a module. --Just an idea-- Im not an experienced C programmer but would
> like to mess with this idea. If anyone has any ideas for more info
> please email them to me.

This is what early userspace is supposed to be for. IIRC there is a
stripped down dhcp client for booting off an nfsroot already there.


-- wli
