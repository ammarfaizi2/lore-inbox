Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261158AbSJHNNj>; Tue, 8 Oct 2002 09:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262435AbSJHNNj>; Tue, 8 Oct 2002 09:13:39 -0400
Received: from 62-190-201-48.pdu.pipex.net ([62.190.201.48]:11524 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S261158AbSJHNNh>; Tue, 8 Oct 2002 09:13:37 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210081327.g98DRatM000391@darkstar.example.net>
Subject: Re: Re: The reason to call it 3.0 is the desktop (was Re: [OT] 2.6 not 3.0 -  (NUMA))
To: Hell.Surfers@cwctv.net
Date: Tue, 8 Oct 2002 14:27:36 +0100 (BST)
Cc: jlnance@intrex.net, linux-kernel@vger.kernel.org
In-Reply-To: <00e3723041308a2DTVMAIL7@smtp.cwctv.net> from "Hell.Surfers@cwctv.net" at Oct 08, 2002 02:06:02 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >     Do you think it would be better to make the defragmentation part of
> > the normal operation of the FS rather than a seperate application.  For
> > example, if you did a fragmentation check/fix on the last close of a file
> > you would know that coherency issues were not going to be important.  It
> > might also give you some way to determine which files were important to
> > keep close together.

> sounds good, could a space wiper be made for secret
> agencies/buisness throwing away old hdds?

They can just do:

dd if=/dev/urandom of=/dev/hda
dd if=/dev/zero of=/dev/hda

John.
