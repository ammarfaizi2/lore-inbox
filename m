Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261895AbVBOV2g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261895AbVBOV2g (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Feb 2005 16:28:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261899AbVBOV2g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Feb 2005 16:28:36 -0500
Received: from wproxy.gmail.com ([64.233.184.194]:55269 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261895AbVBOV2d convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Feb 2005 16:28:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:in-reply-to:references:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=NCW0ma4mJVYdUBSnAY+QW9SaU1B6HMSWRDyCOOwAv9XQm5QWm7qskPMBcKYdmHpe+mpDjlKPeRa6RC0npPWrwMTnMMos36cqakyDVxvwnzSwCUsYgeeEai8DEyDIpK665VF9U2uyl3HekfRKljOGepoKm6gPiyRQjBdPquJ0guY=
Date: Tue, 15 Feb 2005 22:11:28 +0100
From: Diego Calleja <diegocg@gmail.com>
To: Adam Goode <adam@evdebs.org>
Cc: linas@austin.ibm.com, rlrevell@joe-job.com, prakashp@arcor.de,
       paolo.ciarrocchi@gmail.com, gregkh@suse.de, pmcfarland@downeast.net,
       linux-hotplug-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Optimizing disk-I/O [was Re: [ANNOUNCE] hotplug-ng 001 release]
Message-Id: <20050215221128.63d5c738.diegocg@gmail.com>
In-Reply-To: <1108500416.17531.35.camel@lynx.auton.cs.cmu.edu>
References: <20050215004329.5b96b5a1.diegocg@gmail.com>
	<20050215195614.GT23424@austin.ibm.com>
	<1108500416.17531.35.camel@lynx.auton.cs.cmu.edu>
X-Mailer: Sylpheed version 1.9.2+svn (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Tue, 15 Feb 2005 15:46:56 -0500,
Adam Goode <adam@evdebs.org> escribió:

> Mac OS X has a similar thing, with a pretty simple description of how
> they do it:
> 
> http://developer.apple.com/technotes/tn/tn1150.html#HotFile

Also all those things are part of darwin i think (or IOW, we can look at how they
did it)
