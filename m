Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265632AbTFSIon (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 04:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265735AbTFSIon
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 04:44:43 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:17169 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S265632AbTFSIol
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 04:44:41 -0400
Date: Thu, 19 Jun 2003 01:55:07 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: DVB updates, 3rd try
Message-ID: <20030619085507.GD20116@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <3EF051AF.1060006@convergence.de> <Pine.LNX.4.44.0306180849150.9782-100000@home.transmeta.com> <20030618161253.GA53261@compsoc.man.ac.uk> <20030619014509.GC20116@pegasys.ws> <20030619021318.GA53393@compsoc.man.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619021318.GA53393@compsoc.man.ac.uk>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 19, 2003 at 03:13:19AM +0100, John Levon wrote:
> On Wed, Jun 18, 2003 at 06:45:09PM -0700, jw schultz wrote:
> 
> > [over-quoting snipped]
> 
> > Please don't do this.  $reply_to ||= $message_id is OK but
> > having each patch as a reply to the previous one is
> > annoying.  I think it was Greg who recently posted one set
> > of patches that was so large the indentation for the thread
> > went off the screen.
> > 
> >        [PATCH 0/n] frob the niggle
> >        |-> [PATCH 1/n] frob the niggle
> >        |-> [PATCH 2/n] frob the niggle
> >        |-> [PATCH 3/n] frob the niggle
> 
> Then the patches don't appear in order in people's mail readers.

So what?  The only time display order matters if one is
dependant on another.  Most of the patch sets i've seen
don't have such dependencies.  Otherwise the enumeration is
just so you know if you have all the patches in a set.  

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
