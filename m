Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262273AbUDHTKG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 15:10:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262286AbUDHTKF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 15:10:05 -0400
Received: from alfie.demon.co.uk ([80.177.172.67]:42503 "EHLO
	alfie.demon.co.uk") by vger.kernel.org with ESMTP id S262273AbUDHTKD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 15:10:03 -0400
Date: Thu, 8 Apr 2004 20:10:01 +0100
From: Nick Holloway <Nick.Holloway@pyrites.org.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6] Add missing MODULE_PARAM to dummy.c (and MAINTAINERShip)
Message-ID: <20040408191001.GA7450@pyrites.org.uk>
References: <20040408174823.GA13335@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040408174823.GA13335@localhost>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 08, 2004 at 07:48:23PM +0200, Jose Luis Domingo Lopez wrote:
> A patch follows to (hopefully) correct this. Another patch includes an
> entry in the MAINTAINERS file for the "dummy" module. However, I suppose 
> the module author (Nick Holloway) will come up and say if he should
> still be considered as the module maintainer, so to add the correct
> information to the MAINTAINERS file.

I wouldn't consider myself the maintainer.  I did the original development
to get it into the tree (nearly 10 years ago), but changes have been
made by others.

I don't think an explicit maintainer needs to be mentioned, as it falls
under the umbrella of network maintainance.

-- 
 `O O'  | Nick.Holloway@pyrites.org.uk
// ^ \\ | http://www.pyrites.org.uk/
