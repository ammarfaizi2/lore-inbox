Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751873AbWCEWCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751873AbWCEWCp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 17:02:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbWCEWCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 17:02:45 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:7392 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751873AbWCEWCo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 17:02:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GTFOqXLRolixDFHd/8oDWGV3DxUEopyK8HGeYyUvU+1hFt64DPph0srHJMVHDDMFOM3W/xRdVZUw1CEfZmi81DQIdz1Sc/hfrNiQgOAoX7xqkC5DPjN6shGJM6QmziXcl8dBSTDTTqIpkPzT3kPMrIbBAZ6x5HBJkVezni9k8Us=
Message-ID: <35fb2e590603051402j1e6f9c92u9b0f5e83dea72678@mail.gmail.com>
Date: Sun, 5 Mar 2006 22:02:43 +0000
From: "Jon Masters" <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: "Robin Holt" <holt@sgi.com>
Subject: Re: [OT] inotify hack for locate
Cc: "Jesper Juhl" <jesper.juhl@gmail.com>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
In-Reply-To: <20060305215318.GA26130@lnx-holt.americas.sgi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <35fb2e590603051336t5d8d7e93i986109bc16a8ec38@mail.gmail.com>
	 <9a8748490603051342r64f1dd65qecf72a8016a0d520@mail.gmail.com>
	 <20060305215318.GA26130@lnx-holt.americas.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/5/06, Robin Holt <holt@sgi.com> wrote:

> I use suspend to disk on my laptop.  When I power it back up in the
> morning, updatedb starts.

It just seems to me that things like Beagle are all well and good, but
what would be really useful to /me/ :-) is a hack for locate. It's
probably been done and I'm rambling for nothing - someone put me out
of my misery with a link?

Or I can look at fixing it for myself otherwise. This is something
Microsoft almost "get right" with their fast indexing service.

Jon.
