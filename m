Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264050AbTDWOQI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 10:16:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264052AbTDWOQI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 10:16:08 -0400
Received: from 101.24.177.216.inaddr.G4.NET ([216.177.24.101]:16512 "EHLO
	sparrow.stearns.org") by vger.kernel.org with ESMTP id S264050AbTDWOQG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 10:16:06 -0400
Date: Wed, 23 Apr 2003 10:27:31 -0400 (EDT)
From: William Stearns <wstearns@pobox.com>
X-X-Sender: wstearns@sparrow
Reply-To: William Stearns <wstearns@pobox.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
cc: Nir Livni <nir_l3@netvision.net.il>,
       ML-linux-kernel <linux-kernel@vger.kernel.org>,
       Erez Zadok <ezk@shekel.mcl.cs.columbia.edu>
Subject: Re: FileSystem Filter Driver
In-Reply-To: <20030423135326.A7131@bitwizard.nl>
Message-ID: <Pine.LNX.4.44.0304231023490.6853-100000@sparrow>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Good day, Nir, Rogier,

On Wed, 23 Apr 2003, Rogier Wolff wrote:

> On Wed, Apr 23, 2003 at 12:28:33PM +0200, Nir Livni wrote:
> > I am looking for information about writing a FileSystem Filter Driver on RH.
> > Any documentation or source code samples whould be appreciated.
> 
> Check out one of the latest Linux Journals. I think they just
> published an article about this!

	The May 2003 issue did include an article from Erez Zadok on the 
topic of the FiST project (File System Translator), which is exactly what 
you're looking for.
	The project homepage is at 
http://www1.cs.columbia.edu/~ezk/research/fist/ .  There are links there 
to the language specification (see his phd dissertation), downloadable 
code, sample filesystems, and a mailing list.
	Cheers,
	- Bill

---------------------------------------------------------------------------
	"Never underestimate the bandwidth of a station wagon full of
tapes."
	-- Dr. Warren Jackson, Director, UTCS
(Courtesy of Clem Yonkers <cyonkers@intervis.com>)
--------------------------------------------------------------------------
William Stearns (wstearns@pobox.com).  Mason, Buildkernel, freedups, p0f,
rsync-backup, ssh-keyinstall, dns-check, more at:   http://www.stearns.org
Linux articles at:                         http://www.opensourcedigest.com
--------------------------------------------------------------------------

