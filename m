Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264293AbTDXC7o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 22:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264302AbTDXC7o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 22:59:44 -0400
Received: from holomorphy.com ([66.224.33.161]:33190 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264293AbTDXC7n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 22:59:43 -0400
Date: Wed, 23 Apr 2003 20:11:45 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [ANNOUNCE] desc.c -- dump the i386 descriptor tables
Message-ID: <20030424031145.GM8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <200304232305_MC3-1-35C1-C1D1@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200304232305_MC3-1-35C1-C1D1@compuserve.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 11:02:02PM -0400, Chuck Ebbert wrote:
>  Sample output:
>  desc.c -- dump linux descriptor tables, version 0.50
>  GDT at c0306280, 32 entries:
> #00: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #01: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>
> #02: base=00000000 limit=0000 flags=0000 <G=0 P=0 S=0 DPL=0 Empty>

Spiffy; this should help debug various things.


-- wli
