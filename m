Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTEFLes (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 07:34:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262584AbTEFLes
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 07:34:48 -0400
Received: from holomorphy.com ([66.224.33.161]:34695 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262577AbTEFLek (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 07:34:40 -0400
Date: Tue, 6 May 2003 04:46:56 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
Message-ID: <20030506114656.GS8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Felix von Leitner <felix-kernel@fefe.de>,
	linux-kernel@vger.kernel.org
References: <20030504173956.GA28370@codeblau.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030504173956.GA28370@codeblau.de>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 04, 2003 at 07:39:56PM +0200, Felix von Leitner wrote:
> I am running several scalability tests on Linux 2.5.68, all related to
> network servers.  My test box is my notebook, Pentium 3 @ 900 MHz, 256
> MB RAM.  I run a small http server on it that supports the following
> models:

I think I found it already; it's going to take a while to produce a fix
for what turned up during my audit.


-- wli
