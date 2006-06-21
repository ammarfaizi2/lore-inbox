Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751250AbWFUKmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250AbWFUKmP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jun 2006 06:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751365AbWFUKmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jun 2006 06:42:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.168]:52242 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751250AbWFUKmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jun 2006 06:42:14 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aKJPK9135xKruSXVWzmXuCvHOWww87WcPGHFZibYQ21043uZb07zNzpSTfmnYkjP5pttyM5KTjpwEJpk0qO8I470rcYCFzWgatyK9qK/9hrXT5qgDJ7yAIYv4w9MJcIBobwEAgzrJMn5UwcMm+jZa6SvQ1ekttZAb+/JZVQS7kU=
Message-ID: <69304d110606210342j3868a2a1v6577be4c192a521c@mail.gmail.com>
Date: Wed, 21 Jun 2006 12:42:13 +0200
From: "Antonio Vargas" <windenntw@gmail.com>
To: "Stefan Richter" <stefanr@s5r6.in-berlin.de>,
       "Jeff Anderson-Lee" <jonah@eecs.berkeley.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] suggestion [PATCH N/M] subject lines
In-Reply-To: <44991787.7010602@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <000001c694bb$f9fa3f40$ce2a2080@eecs.berkeley.edu>
	 <44991787.7010602@s5r6.in-berlin.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/21/06, Stefan Richter <stefanr@s5r6.in-berlin.de> wrote:
> Jeff Anderson-Lee wrote:
> > Reading the mailing list with a non-threads compatible
> > mail client agent would be made much easier if the
> > convention for subject lines for multi-part patches was
> > changed to the following:
> >
> >       patch set name [PATCH N/M] patch summary
> >
> > Then sorting by subject would group all patches for the
> > Same patch set together.
>
> A workaround is to sort by (1.) author + (2.) date. Should help in many
> cases.
>
> > I don't know if these Subject lines are hand generated, or if there
> > is software involved that would have to me modified for generating
> > and/or parsing them.
>
> All of it is true.

There is at least a built-in command to akpm's patch management
scripts which genrates patch-bombs:

http://www.zip.com.au/~akpm/linux/patches/patch-scripts-0.20/docco.txt

thus maybe its descendant "quilt" also does have


-- 
Greetz, Antonio Vargas aka winden of network

Every day, every year
you have to work
you have to study
you have to scene.
