Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265697AbTFSB7X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbTFSB7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:59:23 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:12047 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP id S265697AbTFSB7W
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:59:22 -0400
Date: Thu, 19 Jun 2003 03:13:19 +0100
From: John Levon <levon@movementarian.org>
To: jw schultz <jw@pegasys.ws>, linux-kernel@vger.kernel.org
Subject: Re: DVB updates, 3rd try
Message-ID: <20030619021318.GA53393@compsoc.man.ac.uk>
References: <3EF051AF.1060006@convergence.de> <Pine.LNX.4.44.0306180849150.9782-100000@home.transmeta.com> <20030618161253.GA53261@compsoc.man.ac.uk> <20030619014509.GC20116@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030619014509.GC20116@pegasys.ws>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19SovP-000GF2-Ou*tjk1XJlBg9Y*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 06:45:09PM -0700, jw schultz wrote:

> [over-quoting snipped]

> Please don't do this.  $reply_to ||= $message_id is OK but
> having each patch as a reply to the previous one is
> annoying.  I think it was Greg who recently posted one set
> of patches that was so large the indentation for the thread
> went off the screen.
> 
>        [PATCH 0/n] frob the niggle
>        |-> [PATCH 1/n] frob the niggle
>        |-> [PATCH 2/n] frob the niggle
>        |-> [PATCH 3/n] frob the niggle

Then the patches don't appear in order in people's mail readers.

john
