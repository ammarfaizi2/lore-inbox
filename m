Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265725AbTIJUgF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 16:36:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265726AbTIJUgE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 16:36:04 -0400
Received: from stroke.of.genius.brain.org ([206.80.113.1]:64184 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id S265725AbTIJUgB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 16:36:01 -0400
Date: Wed, 10 Sep 2003 16:35:51 -0400
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: ide-scsi oops was: 2.6.0-test4-mm3
Message-ID: <20030910203551.GA1376@Master>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030910114346.025fdb59.akpm@osdl.org> <10720000.1063224243@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <10720000.1063224243@flay>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 10, 2003 at 01:04:03PM -0700, Martin J. Bligh wrote:
> >> I have another oops for you with 2.6.0-test4-mm3-1 and ide-scsi. 
> > 
> > ide-scsi is a dead duck.  defunct.  kaput.  Don't use it.  It's only being
> > kept around for weirdo things like IDE-based tape drives, scanners, etc.
> > 
> > Just use /dev/hdX directly.
> 
> That's a real shame ... it seemed to work fine until recently. Some
> of the DVD writers (eg the one I have - Sony DRU500A or whatever)
> need it. Is it unfixable? or just nobody's done it?
> 

I hope it's working in test5 - it works in test4. I need it for my Sony CD 
writer, since without it cdrecord doesn't think it has write capability.

-- 
Murray J. Root

