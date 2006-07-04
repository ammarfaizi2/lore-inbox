Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932307AbWGDXsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932307AbWGDXsJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jul 2006 19:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932359AbWGDXsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jul 2006 19:48:09 -0400
Received: from smtp2.ist.utl.pt ([193.136.128.22]:38822 "EHLO smtp2.ist.utl.pt")
	by vger.kernel.org with ESMTP id S932307AbWGDXsI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jul 2006 19:48:08 -0400
From: Claudio Martins <ctpm@ist.utl.pt>
To: Frank van Maarseveen <frankvm@frankvm.com>
Subject: Re: ext4 features
Date: Wed, 5 Jul 2006 00:47:56 +0100
User-Agent: KMail/1.9.1
Cc: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>,
       Arjan van de Ven <arjan@infradead.org>, Tomasz Torcz <zdzichu@irc.pl>,
       Helge Hafting <helgehaf@aitel.hist.no>,
       Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
       "Theodore Ts'o" <tytso@mit.edu>, LKML <linux-kernel@vger.kernel.org>
References: <20060701163301.GB24570@cip.informatik.uni-erlangen.de> <44A9904F.7060207@wolfmountaingroup.com> <20060704223542.GA16828@janus>
In-Reply-To: <20060704223542.GA16828@janus>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200607050047.57978.ctpm@ist.utl.pt>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tuesday 04 July 2006 23:35, Frank van Maarseveen wrote:
>
> Do you have any idea how to undo the effect of rm -rf /bigtree at
> the FS level?
>
> I think such an "undelete" feature should be implemented in userspace.
> A filesystem which can travel back in time could be useful however.

 Indeed.

 See:

http://lkml.org/lkml/2006/7/1/114

 I'm starting to repeat myself, but at least one filesystem of that kind is 
already being developed, lets try to support them! :-)

Regards

Cláudio

