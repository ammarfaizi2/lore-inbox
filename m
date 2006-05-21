Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751504AbWEUIQY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751504AbWEUIQY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 May 2006 04:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751478AbWEUIQY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 May 2006 04:16:24 -0400
Received: from smtp108.sbc.mail.mud.yahoo.com ([68.142.198.207]:58810 "HELO
	smtp108.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1751504AbWEUIQX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 May 2006 04:16:23 -0400
Date: Sun, 21 May 2006 01:16:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Haar J?nos <djani22@netcenter.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: swapper: page allocation failure.
Message-ID: <20060521081621.GA1151@taniwha.stupidest.org>
References: <00e901c67cad$fe9a9d90$1800a8c0@dcccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00e901c67cad$fe9a9d90$1800a8c0@dcccs>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 21, 2006 at 10:10:13AM +0200, Haar J?nos wrote:

> This server have 2GB ram, and ~1.1G always free!
> Anybody have an idea?

you ran out of lowmem?

what kernel is this and how do you trigger it?
