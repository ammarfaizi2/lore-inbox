Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262329AbUHQDlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262329AbUHQDlf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 23:41:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268085AbUHQDlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 23:41:35 -0400
Received: from holomorphy.com ([207.189.100.168]:3244 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262329AbUHQDle (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 23:41:34 -0400
Date: Mon, 16 Aug 2004 20:41:31 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.8.1-mm1
Message-ID: <20040817034131.GJ11200@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040816143710.1cd0bd2c.akpm@osdl.org> <20040817030748.GH11200@holomorphy.com> <20040817030957.GI11200@holomorphy.com> <20040816201915.544df590.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040816201915.544df590.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III <wli@holomorphy.com> wrote:
>> How did you compile on ia64? I get:

On Mon, Aug 16, 2004 at 08:19:15PM -0700, Andrew Morton wrote:
> I suspect I got lucky.
> People are saying that `make -j1' will work around this.

Comes up fine on Altix, so it appears kill-clone_idletask-fix.patch
took care of everything.


-- wli
