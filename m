Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262676AbVF2VNz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262676AbVF2VNz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 17:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262648AbVF2VNy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 17:13:54 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31978 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S262650AbVF2VKp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 17:10:45 -0400
Date: Thu, 30 Jun 2005 07:10:28 +1000
From: Nathan Scott <nathans@sgi.com>
To: Steve Lord <lord@xfs.org>
Cc: Chris Wedgwood <cw@f00f.org>, Al Boldi <a1426z@gawab.com>,
       linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, reiserfs-list@namesys.com
Subject: Re: XFS corruption during power-blackout
Message-ID: <20050630071027.A2559808@wobbly.melbourne.sgi.com>
References: <20050629001847.GB850@frodo> <200506290453.HAA14576@raad.intranet> <556815.441dd7d1ebc32b4a80e049e0ddca5d18e872c6e8a722b2aefa7525e9504533049d801014.ANY@taniwha.stupidest.org> <42C2E0BC.8040508@xfs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <42C2E0BC.8040508@xfs.org>; from lord@xfs.org on Wed, Jun 29, 2005 at 12:56:12PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2005 at 12:56:12PM -0500, Steve Lord wrote:
> I did spend a bunch of time once ensuring that when you typed
> sync on xfs you could pull the power right after that and
> everything from before the sync survived. There have been a
> lot of changes both in xfs and the surrounding kernel since
> then. I do not know if anyone has attempted this effort
> again recently.

Yep, someone has, a number of times.  And as Homer would say
"its still good!".

cheers.

-- 
Nathan
