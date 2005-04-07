Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262479AbVDGPHi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262479AbVDGPHi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 11:07:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262485AbVDGPHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 11:07:38 -0400
Received: from smtp.istop.com ([66.11.167.126]:20951 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262479AbVDGPHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 11:07:19 -0400
From: Daniel Phillips <phillips@istop.com>
To: Martin Pool <mbp@sourcefrog.net>
Subject: Re: Kernel SCM saga..
Date: Thu, 7 Apr 2005 11:08:29 -0400
User-Agent: KMail/1.7
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org> <pan.2005.04.07.01.40.20.998237@sourcefrog.net> <200504062335.25732.phillips@istop.com>
In-Reply-To: <200504062335.25732.phillips@istop.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200504071108.29623.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 06 April 2005 23:35, Daniel Phillips wrote:
> When I tried it, it took 13 seconds to 'bzr add' the 2.6.11.3 tree on a
> relatively slow machine.

Oh, and 135 seconds to commit, so 148 seconds overall.  Versus 87 seconds to 
to bunzip the tree in the first place.  So far, you are in the ballpark.

Regards,

Daniel
