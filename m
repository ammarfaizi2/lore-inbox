Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbTLHSv2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 13:51:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261660AbTLHSv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 13:51:27 -0500
Received: from holomorphy.com ([199.26.172.102]:11228 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261659AbTLHSv0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 13:51:26 -0500
Date: Mon, 8 Dec 2003 10:51:21 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Volkov <Andrew.Volkov@transas.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: possible proceses leak
Message-ID: <20031208185121.GM8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Volkov <Andrew.Volkov@transas.com>,
	linux-kernel@vger.kernel.org
References: <2E74F312D6980D459F3A05492BA40F8D0391B0EE@clue.transas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2E74F312D6980D459F3A05492BA40F8D0391B0EE@clue.transas.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 08, 2003 at 09:45:17PM +0300, Andrew Volkov wrote:
> Yes.
> And same bug in kernel/sched.c in ALL *_sleep_on
> Andrey

Heh, no wonder everyone wants to get rid of the things.


-- wli
