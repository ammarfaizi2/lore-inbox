Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264267AbTLJXkg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Dec 2003 18:40:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264270AbTLJXkg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Dec 2003 18:40:36 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:62898 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S264267AbTLJXkd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Dec 2003 18:40:33 -0500
Date: Wed, 10 Dec 2003 15:40:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Paul Jakma <paul@clubi.ie>
Cc: venom@sns.it, "Martin J. Bligh" <mbligh@aracnet.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Joe Thornber <thornber@sistina.com>, linux-kernel@vger.kernel.org
Subject: Re: Device-mapper submission for 2.4
Message-ID: <20031210234007.GD15401@matchmail.com>
Mail-Followup-To: Paul Jakma <paul@clubi.ie>, venom@sns.it,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
	Joe Thornber <thornber@sistina.com>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0312101753040.24122-100000@cibs9.sns.it> <Pine.LNX.4.56.0312101659260.1218@fogarty.jakma.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.56.0312101659260.1218@fogarty.jakma.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 10, 2003 at 05:00:43PM +0000, Paul Jakma wrote:
> On Wed, 10 Dec 2003 venom@sns.it wrote:
> 
> > DM is back compatible with LVM1, tested and runs well.
> 
> What about the patches posted by Joe last (?) week which remove LVM1 
> support from 2.6 DM? (if Linus hasnt picked them up, its surely an 

If this is what I was reading being discussed a few weeks ago, then the
support for the LVM1 sysctls/ioctls has/will be removed, so you will have to
use the DM utilities instead of the old LVM1 utilities.  LVM1 on-disk format
should still be supported.
