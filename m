Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264043AbTKSNCh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Nov 2003 08:02:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbTKSNCh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Nov 2003 08:02:37 -0500
Received: from holomorphy.com ([199.26.172.102]:44201 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S264043AbTKSNCg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Nov 2003 08:02:36 -0500
Date: Wed, 19 Nov 2003 05:02:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Ronny V. Vindenes" <s864@ii.uib.no>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.0-test9-mm4 - kernel BUG at arch/i386/mm/fault.c:357!
Message-ID: <20031119130220.GT22764@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Ronny V. Vindenes" <s864@ii.uib.no>, Andrew Morton <akpm@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1069246427.5257.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1069246427.5257.12.camel@localhost.localdomain>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 19, 2003 at 01:53:47PM +0100, Ronny V. Vindenes wrote:
> Running the game Enemy Territory triggers this (log is from running it 3
> times in a row) every time. Haven't been able to trigger it with any
> other programs. Machine is athlon64 running all 32bit.
> On a happier note, interactivity problems are gone with the new acpi pm
> timer patch.

What sound card?


-- wli
