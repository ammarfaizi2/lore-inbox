Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262603AbTL2D6I (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 22:58:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262610AbTL2D6I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 22:58:08 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:44037
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id S262603AbTL2D6F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 22:58:05 -0500
Date: Sun, 28 Dec 2003 19:56:14 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Mike Fedyk <mfedyk@matchmail.com>
cc: akmiller@nzol.net, linux-kernel@vger.kernel.org
Subject: Re: ide: "lost interrupt" with 2.6.0
In-Reply-To: <20031229035533.GG1882@matchmail.com>
Message-ID: <Pine.LNX.4.10.10312281955190.32122-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Dupli-Disk requires taskfile access and will correctly operate.

Accusys is total CRAP, unless they licensed the technology proper.

Andre Hedrick
LAD Storage Consulting Group

On Sun, 28 Dec 2003, Mike Fedyk wrote:

> On Sun, Dec 28, 2003 at 07:37:37PM -0800, Andre Hedrick wrote:
> > I know the FSM's are wrong because I fixed them for Dupli-Disk.
> > How they operate, I can not disclose.  But Accusys can not handle correct
> > settings for FSM to Taskfile.
> 
> Does that mean that if you use taskfile on Dupli-Disk controllers that they
> will fail, and that disabling taskfile access might help (is that still an
> option in 2.6?)
> 

