Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261765AbTCLQAq>; Wed, 12 Mar 2003 11:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261776AbTCLQAq>; Wed, 12 Mar 2003 11:00:46 -0500
Received: from mx12.arcor-online.net ([151.189.8.88]:4834 "EHLO
	mx12.arcor-online.net") by vger.kernel.org with ESMTP
	id <S261765AbTCLP7E>; Wed, 12 Mar 2003 10:59:04 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>,
       Zack Brown <zbrown@tumblerings.org>
Subject: Re: BitBucket: GPL-ed KitBeeper clone
Date: Wed, 12 Mar 2003 17:13:39 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <200303121532.h2CFWctg001873@eeyore.valparaiso.cl>
In-Reply-To: <200303121532.h2CFWctg001873@eeyore.valparaiso.cl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20030312160948.7FA05106EBE@mx12.arcor-online.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 12 Mar 03 16:32, Horst von Brand wrote:
> ...a changeset is local, or something to be sent out and merged elsewhere
> (where due to the merging it loses its former identity). Think traditional
> patches: I can create a patch here, give it to you. But what you end
> applying is different due to changes at your place. You apply a different
> patch.

This is why changesets need to be first-class objects in the repository,
that can be versioned, segmented and recombined.  I'd be able to pull 
slightly differing changesets from a variety of sources, *merge
the changesets* and carry the result forward in my repository.  This
way, no changeset needs to lose its identity until I explicity want it
to.

Regards,

Daniel
