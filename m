Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263681AbTEJID1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 04:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263693AbTEJID1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 04:03:27 -0400
Received: from holomorphy.com ([66.224.33.161]:6053 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263681AbTEJID0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 04:03:26 -0400
Date: Sat, 10 May 2003 01:15:59 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.5] small cleanup for __rmqueue
Message-ID: <20030510081559.GG8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Zwane Mwaikambo <zwane@linuxpower.ca>,
	Linux Kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.50.0305100227120.11047-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0305100227120.11047-100000@montezuma.mastecende.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 10, 2003 at 03:59:31AM -0400, Zwane Mwaikambo wrote:
> Removes an extra initialisation and general nitpicking.

Looks good. I like the elimination of the superfluous variables.


-- wli
