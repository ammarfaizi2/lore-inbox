Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263808AbTEFOSf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 10:18:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263809AbTEFOSe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 10:18:34 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49901 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263808AbTEFOR4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 10:17:56 -0400
Date: Tue, 6 May 2003 15:30:26 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Alex Riesen <alexander.riesen@synopsys.COM>
Cc: linux-kernel@vger.kernel.org, Eric Lammerts <eric@lammerts.org>
Subject: Re: Fwd: allow rename to "--bind"-mounted filesystem
Message-ID: <20030506143026.GL10374@parcelfarce.linux.theplanet.co.uk>
References: <20030506100435.GH890@riesen-pc.gr05.synopsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030506100435.GH890@riesen-pc.gr05.synopsys.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 06, 2003 at 12:04:35PM +0200, Alex Riesen wrote:
> Hi,
> i just came over this patch, and wondered why is it missing
> in both 2.4 and 2.5 (the code in do_rename is identical in both
> kernels).
> 
> Are such renames really not allowed, or was it just fixed differently?

Such remames are _deliberately_ not allowed.
