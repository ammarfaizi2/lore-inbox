Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264340AbTFEArt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 20:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbTFEArt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 20:47:49 -0400
Received: from vladimir.pegasys.ws ([64.220.160.58]:45840 "EHLO
	vladimir.pegasys.ws") by vger.kernel.org with ESMTP id S264340AbTFEArs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 20:47:48 -0400
Date: Wed, 4 Jun 2003 17:58:19 -0700
From: jw schultz <jw@pegasys.ws>
To: linux-kernel@vger.kernel.org
Subject: Re: size of... (was: lk-changelog.pl 0.124)
Message-ID: <20030605005819.GC19053@pegasys.ws>
Mail-Followup-To: jw schultz <jw@pegasys.ws>,
	linux-kernel@vger.kernel.org
References: <20030604190143.3314F89AEA@merlin.emma.line.org> <20030604190553.GA8666@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030604190553.GA8666@merlin.emma.line.org>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 04, 2003 at 09:05:53PM +0200, Matthias Andree wrote:
> BTW, what is the maximum size that people will bear for linux-kernel
> mails? This damn Perl script has grown damn big...

I think you are very close to the limit.

I'd consider splitting the script up a bit.  Put the
%addresses hash into a separate file perhaps.  You also
might just post the changlog and diffs.

-- 
________________________________________________________________
	J.W. Schultz            Pegasystems Technologies
	email address:		jw@pegasys.ws

		Remember Cernan and Schmitt
