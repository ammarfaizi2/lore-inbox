Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310190AbSCUKne>; Thu, 21 Mar 2002 05:43:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310206AbSCUKnY>; Thu, 21 Mar 2002 05:43:24 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:52428 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S310190AbSCUKnM>; Thu, 21 Mar 2002 05:43:12 -0500
Date: Thu, 21 Mar 2002 05:43:06 -0500
From: Tim Waugh <twaugh@redhat.com>
To: Martin Blais <blais@iro.umontreal.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: xxdiff as a visual diff tool (shameless plug)
Message-ID: <20020321054306.C14095@redhat.com>
In-Reply-To: <20020321061423.HIXG2746.tomts17-srv.bellnexxia.net@there>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 21, 2002 at 01:13:32AM -0500, Martin Blais wrote:

> It does not do edits at this point because I felt everyone has
> their own strong preferences for editing files.

Incidentally, on a related subject: editdiff (from patchutils) can do
simple hunk editing.  Use emacs or vi to hand-edit a patch, and it
will fix up offsets and counts for you.

Tim.
*/
