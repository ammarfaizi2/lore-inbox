Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272074AbRIJWfn>; Mon, 10 Sep 2001 18:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272076AbRIJWfX>; Mon, 10 Sep 2001 18:35:23 -0400
Received: from ppp0.ocs.com.au ([203.34.97.3]:2821 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S272074AbRIJWfR>;
	Mon, 10 Sep 2001 18:35:17 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: David Mansfield <david@ultramaster.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kbuild 2.5 question about generated files 
In-Reply-To: Your message of "Mon, 10 Sep 2001 11:23:36 -0400."
             <Pine.LNX.4.33.0109101118120.24063-100000@mercury.ultramaster.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Tue, 11 Sep 2001 08:34:39 +1000
Message-ID: <25451.1000161279@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Sep 2001 11:23:36 -0400 (EDT), 
David Mansfield <david@ultramaster.com> wrote:
>I've read the release announcements about the new kbuild and it sounds
>like it will be possible to build from kernel sources that reside on a
>read-only filesystem?  Is that the case?

Yes.  Run with separate source and object directories and nothing
expect last access time stamp is updated in the source directory.

