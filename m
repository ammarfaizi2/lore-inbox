Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275017AbTHQCTn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 22:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275021AbTHQCTm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 22:19:42 -0400
Received: from holomorphy.com ([66.224.33.161]:23008 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S275017AbTHQCTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 22:19:41 -0400
Date: Sat, 16 Aug 2003 19:20:54 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Paul Dickson <dickson@permanentmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH]O14int
Message-ID: <20030817022054.GP32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Paul Dickson <dickson@permanentmail.com>,
	linux-kernel@vger.kernel.org
References: <200308090149.25688.kernel@kolivas.org> <200308120033.32391.kernel@kolivas.org> <1060615179.13255.133.camel@workshop.saharacpt.lan> <200308121545.52042.kernel@kolivas.org> <20030814061953.GL32488@holomorphy.com> <20030815164010.09651254.dickson@permanentmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030815164010.09651254.dickson@permanentmail.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Aug 2003 23:19:53 -0700, William Lee Irwin III wrote:
>> I found some strange SMP artifacts that seemed to show a dromedary-like
>> throughput curve with respect to tasks, with one peak at 4 tasks/cpu and
>> another peak at 16 tasks/cpu on a 16x box (for kernel compiles).

On Fri, Aug 15, 2003 at 04:40:10PM -0700, Paul Dickson wrote:
> "Dromedary-like" is a bell-shaped curve.  Perhaps you meant "bactrian-like".
> Sorry.  I couldn't resist posting this.   :-)

Doh. Yes.


-- wli
