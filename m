Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292316AbSCON2b>; Fri, 15 Mar 2002 08:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292294AbSCON2L>; Fri, 15 Mar 2002 08:28:11 -0500
Received: from alpha1.ebi.ac.uk ([193.62.196.122]:37641 "EHLO alpha1.ebi.ac.uk")
	by vger.kernel.org with ESMTP id <S291279AbSCON2E>;
	Fri, 15 Mar 2002 08:28:04 -0500
Message-Id: <200203151327.NAA303879@alpha1.ebi.ac.uk>
Content-Type: text/plain; charset=US-ASCII
From: Jonathan Barker <jbarker@ebi.ac.uk>
Reply-To: jbarker@ebi.ac.uk
Organization: EMBL-EBI
To: linux-kernel@vger.kernel.org
Subject: Re: VFS mediator?
Date: Fri, 15 Mar 2002 14:28:22 +0000
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <200203141351.NAA257264@alpha1.ebi.ac.uk>
In-Reply-To: <200203141351.NAA257264@alpha1.ebi.ac.uk>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Alexander Viro <viro@math.psu.edu>,
        Britt Park <britt@drscience.sciencething.org>,
        David Golden <david.golden@unison.ie>,
        Dominik Kubla <kubla@sciobyte.de>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear All

On Thursday 14 Mar 2002 2:52 pm, I wrote:

> In brief: a kernel module which "exported" VFS requests to a (specified)
> user-space daemon would be useful. My particular application is a daemon
> which generates files on the fly - I would like to expose this as part of
> the filesystem. Ideally, the kernel module would deal with generation of
> fake inode numbers etc and the user-space daemon would simply be asked to
> create a pipe corresponding to a "filename" and (possibly) supply a
> directory tree.

Many thanks for all your useful suggestions. I'll look at them all and (when 
I get time) compile a digest of answers. I'm particularly amused by the very 
groovy perlfs (thanks to David Golden for pointing me towards it). 

Jonathan

