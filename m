Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVDRJNf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVDRJNf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 05:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262000AbVDRJLI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 05:11:08 -0400
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:28327 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S261999AbVDRJKp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 05:10:45 -0400
X-ORBL: [67.124.119.21]
Date: Mon, 18 Apr 2005 02:10:21 -0700
From: Chris Wedgwood <cw@f00f.org>
To: James Courtier-Dutton <James@superbug.co.uk>
Cc: Chris Friesen <cfriesen@nortel.com>,
       Takashi Ikebe <ikebe.takashi@lab.ntt.co.jp>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH x86_64] Live Patching Function on 2.6.11.7
Message-ID: <20050418091021.GC1236@taniwha.stupidest.org>
References: <4263275A.2020405@lab.ntt.co.jp> <20050418040718.GA31163@taniwha.stupidest.org> <4263356D.9080007@lab.ntt.co.jp> <20050418061221.GA32315@taniwha.stupidest.org> <42635518.6040704@nortel.com> <426385FB.1080701@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426385FB.1080701@superbug.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2005 at 11:03:39AM +0100, James Courtier-Dutton wrote:

> I can only think of one other system that might benefit from live
> updates, and that is set top boxes, so bugs can be fixed without the
> user knowing.

hardly mission critical and usually don't have the resources to do
complicate things

much better to rexec/reboot as needed

> This also can be worked around by downloading the bug fixes and only
> installing the bugs fixes when the user is not viewing the
> TV. E.g. When the box has been placed in standby by the user.

again it doesn't need live patching (satellite and cable boxes update
themselves routinely, some certainly do need to periodically reboot to
do this and it's apparently not a problem)
