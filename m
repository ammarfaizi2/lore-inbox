Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266567AbUAWNfx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 08:35:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266570AbUAWNfx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 08:35:53 -0500
Received: from greendale.ukc.ac.uk ([129.12.21.13]:29825 "EHLO
	greendale.ukc.ac.uk") by vger.kernel.org with ESMTP id S266567AbUAWNfw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 08:35:52 -0500
To: law <lkml@tlinx.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: utf8 or utf-8
References: <4010108F.2090408@tlinx.org>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Fri, 23 Jan 2004 13:35:06 +0000
In-Reply-To: <4010108F.2090408@tlinx.org> (lkml@tlinx.org's message of "Thu,
 22 Jan 2004 10:03:59 -0800")
Message-ID: <y2a65f2n5yt.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-UKC-Mail-System: No virus detected
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

law <lkml@tlinx.org> writes:

> Should all references be UTF8 or utf-8?

>From Markus Kuhn's excellent Unicode FAQ:

"The official name and spelling of this encoding is UTF-8, where UTF
stands for UCS Transformation Format. Please do not write UTF-8 in any
documentation text in other ways (such as utf8 or UTF_8), unless of
course you refer to a variable name and not the encoding itself."
<http://www.cl.cam.ac.uk/~mgk25/unicode.html>

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
