Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132959AbRDXKIF>; Tue, 24 Apr 2001 06:08:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133012AbRDXKHz>; Tue, 24 Apr 2001 06:07:55 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:23771 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S132959AbRDXKHj>;
	Tue, 24 Apr 2001 06:07:39 -0400
Date: Tue, 24 Apr 2001 06:07:36 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: David Woodhouse <dwmw2@infradead.org>
cc: Jan Harkes <jaharkes@cs.cmu.edu>,
        Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>,
        Christoph Rohland <cr@sap.com>,
        "David L. Parsley" <parsley@linuxjedi.org>,
        linux-kernel@vger.kernel.org
Subject: Re: hundreds of mount --bind mountpoints? 
In-Reply-To: <27577.988106288@redhat.com>
Message-ID: <Pine.GSO.4.21.0104240601410.6992-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 24 Apr 2001, David Woodhouse wrote:

> 
> viro@math.psu.edu said:
> >  Oh, for crying out loud. All it takes is half an hour per filesystem.
> 
> Half an hour? If it takes more than about 5 minutes for JFFS2 I'd be very
> surprised.

<tone polite> What's stopping you? </tone>
You _are_ JFFS maintainer, aren't you?

